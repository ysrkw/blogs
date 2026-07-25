#!/usr/bin/env bash
# PostToolUse hook: Codex が Markdown を編集したら textlint をかけ、
# 指摘を systemMessage として Codex に返す。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
payload="$(cat)"
patch="$(printf '%s' "$payload" | jq -r '
  if (.tool_input | type) == "string" then
    .tool_input
  else
    (.tool_input.patch // .tool_input.input // empty)
  end
')"

files=()
while IFS= read -r file; do
  [ -n "$file" ] && files+=("$file")
done < <(
  printf '%s\n' "$patch" |
    sed -nE \
      -e 's/^\*\*\* (Add|Update) File: (.*\.md)$/\2/p' \
      -e 's/^\*\*\* Move to: (.*\.md)$/\1/p' |
    while IFS= read -r file; do
      if [[ "$file" = /* ]]; then
        candidate="$file"
      else
        candidate="$REPO_ROOT/$file"
      fi
      [ -f "$candidate" ] && printf '%s\n' "$candidate"
    done |
    sort -u
)

TEXTLINT="$REPO_ROOT/node_modules/.bin/textlint"
if [ ! -x "$TEXTLINT" ] || [ "${#files[@]}" -eq 0 ]; then
  exit 0
fi

if out="$("$TEXTLINT" "${files[@]}" 2>&1)"; then
  exit 0
fi

message="textlint が指摘を出しました:
$out

丸ごと --fix で書き換えず、指摘を1つずつ本人判断で反映してください。"
jq -n --arg message "$message" '{systemMessage: $message}'
