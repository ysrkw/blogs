#!/usr/bin/env bash
# Stop hook: blog 系ファイルが更新されたセッション終了時に /retrospective を促す。
#
# 判定ロジック（セッションをまたいで持続する基準点方式）:
#   - .retrospective-prompted があれば「今 CLI セッションで既に prompt を出した」→ 何もせず終了
#     （1 ターンごとに Stop が発火するため、同一セッション内での連発を防ぐ）
#   - .retrospective-last-prompt（前回 prompt を出した時刻。SessionStart ではリセットしない）
#     より新しい mtime の Markdown が works/ articles/ にあれば prompt
#   - prompt を出したら .retrospective-prompted と .retrospective-last-prompt の両方を touch する
#
# 基準点を「このセッションの開始時刻」ではなく「前回 prompt を出した時刻」にすることで、
# 「後で」と答えた後にターミナルを開き直しただけでは再発火しない。前回 prompt 以降に
# 実質的な新しい編集が無ければ、何度セッションを開き直しても静かなまま。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LAST_PROMPT_FILE="$REPO_ROOT/.claude/.retrospective-last-prompt"
PROMPTED_FILE="$REPO_ROOT/.claude/.retrospective-prompted"

# 読み捨て: payload は使わないが stdin を読まないと hook が固まる環境があるため
cat >/dev/null 2>&1 || true

# 既に今セッションで promptを出していれば終了
if [ -f "$PROMPTED_FILE" ]; then
  exit 0
fi

# 監視対象が存在しない場合はスキップ
have_targets=0
for d in works articles; do
  [ -d "$REPO_ROOT/$d" ] && have_targets=1
done
if [ "$have_targets" -eq 0 ]; then
  exit 0
fi

# 初回導入時のフォールバック: 基準点が無ければ今作って、初回は promptしない
if [ ! -f "$LAST_PROMPT_FILE" ]; then
  touch "$LAST_PROMPT_FILE"
  exit 0
fi

# 前回 prompt 以降に更新された対象 .md があるか
newer=$(find "$REPO_ROOT/works" "$REPO_ROOT/articles" \
  -type f -name '*.md' -newer "$LAST_PROMPT_FILE" 2>/dev/null | head -n 1 || true)
if [ -z "$newer" ]; then
  exit 0
fi

# promptを出すフラグを立てる（今セッションでの再発火防止 + 次回以降の基準点更新）
touch "$PROMPTED_FILE"
touch "$LAST_PROMPT_FILE"

# 振り返りを促す。Stop hook は JSON で {"decision":"block","reason":"..."} を
# 返すと Claude を継続させられる。
cat <<'JSON'
{
  "decision": "block",
  "reason": "このセッションで works/ articles/ に変更があったようです。\n会話を閉じる前に retrospective スキルを発動して、言語化の癖・進め方の気づき・blog システムへの改善提案を docs/ の振り返りメモに書き出してください。\n\n手順:\n1. 直近の会話を 3〜5 行で要約し、ユーザーに「今振り返りますか／後回しにしますか」と確認する\n2. 後回しならそのまま終了して良い\n3. 実施するなら retrospective SKILL.md の手順に沿って docs/ の振り返りメモに追記する\n\nフラグは hook 側で管理するので、Claude 側で .retrospective-state 等を touch する必要はありません。"
}
JSON
