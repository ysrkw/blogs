#!/usr/bin/env bash
# PostToolUse hook: Claude が記事系 Markdown を編集したら textlint をかけ、
# 指摘があれば exit 2 で stderr を Claude に差し戻す（= textlint を「聞かせる」）。
#
# 方針: humanizer 同様、丸ごと --fix で書き換えない。指摘を 1 つずつ本人判断で反映する。
# 対象: drafts/ articles/ の *.md のみ。それ以外は静かに終了。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# stdin の JSON payload から tool_input.file_path を取得（jq 非依存・Node でパース）
file="$(node -e 'let s="";process.stdin.on("data",d=>s+=d);process.stdin.on("end",()=>{try{process.stdout.write(JSON.parse(s)?.tool_input?.file_path||"")}catch{}})')"

# file_path が取れない / 対象ディレクトリの .md でなければ何もしない
if [ -z "$file" ]; then
  exit 0
fi
if ! printf '%s' "$file" | grep -Eq '/(drafts|articles)/.*\.md$'; then
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
