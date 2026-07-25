#!/usr/bin/env bash
# Stop hook: blog 系ファイルが更新された Codex セッションの終了時に
# retrospective を促す。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
LAST_PROMPT_FILE="$REPO_ROOT/.codex/.retrospective-last-prompt"
PROMPTED_FILE="$REPO_ROOT/.codex/.retrospective-prompted"

cat >/dev/null 2>&1 || true

if [ -f "$PROMPTED_FILE" ]; then
  exit 0
fi

if [ ! -d "$REPO_ROOT/works" ] && [ ! -d "$REPO_ROOT/articles" ]; then
  exit 0
fi

if [ ! -f "$LAST_PROMPT_FILE" ]; then
  touch "$LAST_PROMPT_FILE"
  exit 0
fi

newer=$(find "$REPO_ROOT/works" "$REPO_ROOT/articles" \
  -type f -name '*.md' -newer "$LAST_PROMPT_FILE" 2>/dev/null | head -n 1 || true)
if [ -z "$newer" ]; then
  exit 0
fi

touch "$PROMPTED_FILE"
touch "$LAST_PROMPT_FILE"

cat <<'JSON'
{
  "continue": false,
  "stopReason": "このセッションで works/ articles/ に変更があったようです。会話を閉じる前に retrospective スキルを発動してください。",
  "systemMessage": "直近の会話を3〜5行で要約し、ユーザーに「今振り返りますか／後回しにしますか」と確認してください。後回しなら終了し、実施するなら retrospective SKILL.md に沿って docs/ の振り返りメモへ追記します。"
}
JSON
