#!/usr/bin/env bash
# Stop hook: blog 系ファイルが更新されたセッション終了時に /blog-reflect を促す。
#
# 判定ロジック:
#   - .claude/.reflect-state（最後の振り返り or 最後のスキップ判断のタイムスタンプ）より
#     新しい mtime の Markdown が ideas/ drafts/ articles/ にあるか確認
#   - あれば Claude に振り返りを促す（decision=block で reason を返す）
#   - 無ければ何もせず通す
#
# Claude が振り返りを実施 or スキップした後、自身で .claude/.reflect-state を touch する
# （blog-reflect の SKILL.md でフォローアップを誓約させる代わりに、ここでは「promptを出す」だけに留める）。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STATE_FILE="$REPO_ROOT/.claude/.reflect-state"

# 読み捨て: payload は使わないが stdin を読まないと hook が固まる環境があるため
cat >/dev/null 2>&1 || true

# 監視対象が存在しない（まだリポジトリに何も無い）場合はスキップ
have_targets=0
for d in ideas drafts articles; do
  [ -d "$REPO_ROOT/$d" ] && have_targets=1
done
if [ "$have_targets" -eq 0 ]; then
  exit 0
fi

# state ファイルが無ければ「これまで一度も振り返っていない」扱い → 既存ファイルがあるなら促す
if [ ! -f "$STATE_FILE" ]; then
  # 初回: 既存の .md が一つでもあれば促す、無ければ state を初期化して終了
  found=$(find "$REPO_ROOT/ideas" "$REPO_ROOT/drafts" "$REPO_ROOT/articles" \
    -type f -name '*.md' 2>/dev/null | head -n 1 || true)
  if [ -z "$found" ]; then
    touch "$STATE_FILE"
    exit 0
  fi
else
  # state より新しい .md があるか
  newer=$(find "$REPO_ROOT/ideas" "$REPO_ROOT/drafts" "$REPO_ROOT/articles" \
    -type f -name '*.md' -newer "$STATE_FILE" 2>/dev/null | head -n 1 || true)
  if [ -z "$newer" ]; then
    exit 0
  fi
fi

# 振り返りを促す。Claude Code の Stop hook は JSON で
# {"decision":"block","reason":"..."} を返すと Claude を継続させられる。
cat <<'JSON'
{
  "decision": "block",
  "reason": "このセッションで ideas/ drafts/ articles/ に変更があったようです。\n会話を閉じる前に blog-reflect スキルを発動して、言語化の癖・進め方の気づき・既存スキルへの改善提案を knowledge/ に書き出してください。\n\n手順:\n1. 直近の会話を 3〜5 行で要約し、ユーザーに「今振り返りますか／後回しにしますか」と確認する\n2. 後回しなら何もせず、リポジトリルートで `touch .claude/.reflect-state` を実行して終わる\n3. 実施するなら blog-reflect SKILL.md の手順に沿って knowledge/ に追記し、終わったら `touch .claude/.reflect-state` を実行する\n\nどちらの場合も最後に .reflect-state を更新しないと、次回のセッション終了時にも同じ促しが出ます。"
}
JSON
