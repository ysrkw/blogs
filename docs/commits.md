# コミット規約

- Conventional Commits（`commitlint` で検証）
- 記事追加・更新は `docs:` プレフィックス（例: `docs: add article "..."`）
- pre-commit hook（lefthook）で `oxfmt --check`・`oxlint`・`textlint`（ステージした全 `*.md`）が走る
