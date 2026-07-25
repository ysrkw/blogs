#!/usr/bin/env bash
# SessionStart hook: Codex セッション内の振り返り促し済みフラグを初期化する。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cat >/dev/null 2>&1 || true
rm -f "$REPO_ROOT/.codex/.retrospective-prompted"
