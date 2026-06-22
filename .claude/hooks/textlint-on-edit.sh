#!/usr/bin/env bash
# PostToolUse hook: Claude が Markdown を編集したら textlint をかけ、
# 指摘があれば exit 2 で stderr を Claude に差し戻す（= textlint を「聞かせる」）。
#
# 方針: humanizer 同様、丸ごと --fix で書き換えない。指摘を 1 つずつ本人判断で反映する。
# 対象: リポジトリ内の *.md。それ以外は静かに終了（node_modules は .textlintignore 側で除外）。

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

TEXTLINT="$REPO_ROOT/node_modules/.bin/textlint"
if [ ! -x "$TEXTLINT" ]; then
  exit 0
fi

# 通れば exit 0。非ゼロ（指摘あり）なら out を stderr に出して exit 2。
if out="$("$TEXTLINT" "$file" 2>&1)"; then
  exit 0
fi

{
  echo "textlint が指摘を出しました（${file}）:"
  echo "$out"
  echo
  echo "humanizer と同じく、丸ごと --fix で書き換えず、指摘を 1 つずつ本人判断で反映してください。"
} >&2
exit 2
