#!/usr/bin/env bash
# Stop hook: blog 系ファイルが更新されたセッション終了時に /retrospective を促す。
#
# 判定ロジック（セッション単位フラグ方式）:
#   - .retrospective-prompted があれば「今セッションで既に promptを出した」→ 何もせず終了
#   - .retrospective-session（SessionStart hook が touch する今セッション開始時刻）
#     より新しい mtime の Markdown が works/ articles/ にあれば prompt
#   - prompt を出したら .retrospective-prompted を touch して 1 セッション 1 回を保証
#
# この方式により、振り返り完了後の pre-commit oxfmt 等で対象ファイル mtime が
# 更新されても再発火しない。Claude 側で touch する必要は無い（hook が自律管理）。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
SESSION_FILE="$REPO_ROOT/.claude/.retrospective-session"
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

# SessionStart hook が動いていない（古いセッション等）場合のフォールバック:
# session ファイルが無ければ今作って、初回は promptしない
if [ ! -f "$SESSION_FILE" ]; then
  touch "$SESSION_FILE"
  exit 0
fi

# session 開始後に更新された対象 .md があるか
newer=$(find "$REPO_ROOT/works" "$REPO_ROOT/articles" \
  -type f -name '*.md' -newer "$SESSION_FILE" 2>/dev/null | head -n 1 || true)
if [ -z "$newer" ]; then
  exit 0
fi

# promptを出すフラグを立てる（次の Stop で再発火しない）
touch "$PROMPTED_FILE"

# 振り返りを促す。Stop hook は JSON で {"decision":"block","reason":"..."} を
# 返すと Claude を継続させられる。
cat <<'JSON'
{
  "decision": "block",
  "reason": "このセッションで works/ articles/ に変更があったようです。\n会話を閉じる前に retrospective スキルを発動して、言語化の癖・進め方の気づき・blog システムへの改善提案を docs/ の振り返りメモに書き出してください。\n\n手順:\n1. 直近の会話を 3〜5 行で要約し、ユーザーに「今振り返りますか／後回しにしますか」と確認する\n2. 後回しならそのまま終了して良い\n3. 実施するなら retrospective SKILL.md の手順に沿って docs/ の振り返りメモに追記する\n\nフラグは hook 側で管理するので、Claude 側で .retrospective-state 等を touch する必要はありません。"
}
JSON
