#!/usr/bin/env bash
# SessionStart hook: セッション開始時に振り返りトリガの「今セッションで promptを出したか」
# フラグだけをリセットする。
#
# 役割:
#   - .retrospective-prompted を削除（今 CLI セッションで prompt 済みかのフラグを初期化）
#
# .retrospective-last-prompt（前回 prompt を出した時刻）はここではリセットしない。
# セッションをまたいで持続させることで、「後で」と答えた直後にセッションを開き直した
# だけでは再発火しないようにしている（retrospective-trigger.sh 参照）。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# stdin を読み捨て（payload は使わないが hook が固まる環境対策）
cat >/dev/null 2>&1 || true

rm -f "$REPO_ROOT/.claude/.retrospective-prompted"

exit 0
