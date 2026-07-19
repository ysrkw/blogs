#!/usr/bin/env bash
# PostToolUse hook: Claude が Markdown を編集したら markdownlint をかけ、
# 指摘があれば exit 2 で stderr を Claude に差し戻す（= markdownlint を「聞かせる」）。
#
# 方針: textlint hook と揃え、丸ごと --fix で書き換えない。指摘を 1 つずつ本人判断で反映する
# （機械的な修正が要るなら `pnpm markdownlint:fix` を手動で走らせる）。
# 対象: リポジトリ内の *.md。それ以外は静かに終了（node_modules は設定側の ignores で除外）。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# stdin の JSON payload から tool_input.file_path を取得（jq でパース）
file="$(jq -r '.tool_input.file_path // empty')"

# file_path が取れない / .md でなければ何もしない
if [ -z "$file" ]; then
  exit 0
fi
if ! printf '%s' "$file" | grep -Eq '\.md$'; then
  exit 0
fi

MDLINT="$REPO_ROOT/node_modules/.bin/markdownlint-cli2"
if [ ! -x "$MDLINT" ]; then
  exit 0
fi

# 通れば exit 0。非ゼロ（指摘あり）なら out を stderr に出して exit 2。
if out="$("$MDLINT" "$file" 2>&1)"; then
  exit 0
fi

{
  echo "markdownlint が指摘を出しました（${file}）:"
  echo "$out"
  echo
  echo "textlint と同じく、丸ごと --fix で書き換えず、指摘を 1 つずつ本人判断で反映してください（機械的な修正は pnpm markdownlint:fix）。"
} >&2
exit 2
