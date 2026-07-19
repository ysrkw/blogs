# ディレクトリ構成・命名規則・コミット規約

## ディレクトリ構成

| パス                     | 役割                                                                         |
| ------------------------ | ---------------------------------------------------------------------------- |
| `ideas/`                 | `/blog-ideate` の出力。コンセプトメモ。日付なしファイル名                    |
| `drafts/{slug}/`         | `/blog-outline`〜`/blog-draft` の作業場（outline.md, article.md）。日付なし  |
| `articles/`              | 公開済み記事。ここでだけ `YYYY-MM-DD-{slug}.md` の形式で日付を付ける         |
| `knowledge/`             | `/blog-reflect` の出力。書き手の癖・進め方・スキル改善案の長期メモ           |
| `docs/`                  | ワークフロー・スキル・規約・校正のドキュメント                               |
| `.claude/skills/blog-*/` | ワークフロー用 SKILL。各記事の雛形は SKILL.md 末尾にコードブロックとして同梱 |

## ファイル命名規則

- `ideas/{slug}.md`: 日付なし
- `drafts/{slug}/outline.md`, `drafts/{slug}/article.md`: 日付なし
- `articles/{YYYY-MM-DD}-{slug}.md`: `/blog-polish` で公開する瞬間に日付を付与

スラグは `kebab-case-title`。ideate → outline → draft → polish を貫いて同じスラグを使う。

## Markdown の書き方

- リンクはインライン形式 `[text](url)` で書く。参照形式 `[text][ref]` は orca のプレビューで表示されないため使わない

## コミット規約

- Conventional Commits（`commitlint` で検証）
- 記事追加・更新は `docs:` プレフィックス（例: `docs: add article "..."`）
- pre-commit hook（lefthook）で `oxfmt --check`・`oxlint`・`textlint`（ステージした全 `*.md`）が走る
