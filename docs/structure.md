# 構成

このリポジトリの各種構造をまとめる。別の構造（frontmatter の並びなど）が増えたらここに節を足す。

## ディレクトリ構造

| パス             | 役割                                                                                            |
| ---------------- | ----------------------------------------------------------------------------------------------- |
| `ideas/`         | `/blog-ideate` の出力。コンセプトメモ。日付なしファイル名                                       |
| `drafts/{slug}/` | `/blog-outline`〜`/blog-draft` の作業場（outline.md, article.md, 補強候補は todo.md）。日付なし |
| `articles/`      | 公開済み記事。ここでだけ `YYYY-MM-DD-{slug}.md` の形式で日付を付ける                            |
| `notes/`         | `/blog-reflect` の長期メモ（書き手の癖・進め方・改善案）。索引は [notes.md](./notes.md)         |
| `books/`         | `/book-log` の読書記録。参考文献・根拠の再利用用。索引は [books.md](./books.md)                 |
| `docs/`          | ワークフロー・スキル・規約・校正のドキュメント                                                  |

### 命名規則

- スラグは `kebab-case-title`。ideate → outline → draft → polish を貫いて同じスラグを使う
- 日付を付けるのは `/blog-polish` で `articles/` に移す公開記事と、`notes/sessions/` の生メモのみ（`{YYYY-MM-DD}-{slug}.md` 形式）。`ideas/`・`drafts/` など途中段階は日付なし

記事ファイルの frontmatter は [templates.md](./templates.md) を参照。
