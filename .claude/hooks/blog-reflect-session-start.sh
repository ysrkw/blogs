#!/usr/bin/env bash
# SessionStart hook: セッション開始時に振り返りトリガの状態をリセットする。
#
# 役割:
#   - .reflect-prompted を削除（今セッション「promptを出したか」フラグの初期化）
#   - .reflect-session を touch（今セッション開始時刻の基準として保存）
#
# これにより blog-reflect-trigger.sh は「セッション開始後に対象ファイルが
# 更新されたか」だけで判定でき、振り返り後の oxfmt 等による mtime 更新で
# 再発火するループを起こさない。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# stdin を読み捨て（payload は使わないが hook が固まる環境対策）
cat >/dev/null 2>&1 || true

rm -f "$REPO_ROOT/.claude/.reflect-prompted"
touch "$REPO_ROOT/.claude/.reflect-session"

exit 0
