# 構成

このリポジトリの各種構造をまとめる。別の構造（frontmatter の並びなど）が増えたらここに節を足す。

## ディレクトリ構造

| パス                 | 役割                                                                                                     |
| -------------------- | -------------------------------------------------------------------------------------------------------- |
| `works/{slug}/`      | `/blog-ideate`〜`/blog-review` の作業場（idea.md, outline.md, article.md, review.md）。日付なし          |
| `articles/`          | 公開済み記事。ここでだけ `YYYY-MM-DD-{slug}.md` の形式で日付を付ける                                     |
| `docs/`              | ワークフロー・スキル・規約・校正のドキュメント。振り返りメモ（process-notes.md / improvements.md）もここ |
| `docs/session-logs/` | `/retrospective` のセッション単位の生メモ（`{YYYY-MM-DD}-{slug}.md`）                                    |
| `docs/books/`        | `/book-log` の読書記録。参考文献・根拠の再利用用。索引は [books.md](./books.md)                          |
| `docs/sources/`      | `/source-log` の動画・Web記事・論文の記録。索引は [sources.md](./sources.md)                             |

`ideas/` と `drafts/` は別ディレクトリだったが、記事のスラグが決まった時点から公開前まで同じ working ファイル群だった。その実態に合わせて `works/{slug}/` に統合した（2026-07-20）。

### 命名規則

- スラグは `kebab-case-title`。ideate → outline → draft → review → publish を貫いて同じスラグを使う
- 日付を付けるのは `/blog-publish` で `articles/` に移す公開記事と、`docs/session-logs/` の生メモのみ（`{YYYY-MM-DD}-{slug}.md` 形式）。`works/` 配下の途中段階は日付なし

記事ファイルの frontmatter は [templates.md](./templates.md) を参照。

### works/{slug}/todo.md が生まれるケース

`todo.md` は `works/{slug}/` に最初から置く雛形ではない。`/blog-writing` や `/blog-review` の途中で「本文には即書かないが逃したくない補強候補・大きめの課題」が出た時点で、その回のスキルが初めて作る。存在しなければ、まだ何も逃がしていないというだけで、無いこと自体が異常ではない。

- `/blog-writing`（執筆モード）: セクション執筆中に湧いた新しい角度・追加セクション案を書く（発散を止めてベースを先に固めるため）
- `/blog-writing`（通し読みモード）: 通し読みで見つけた大きめの課題（1 ブロックでは扱いきれない指摘）を書く
- `/blog-review`: 客観チェックで見つかったが、今回は反映を見送った指摘を書く
- 消化した項目は `/retrospective` で `docs/process-notes.md` 等へ吸収してから削除する。運用は [writing-policy.md](./writing-policy.md) を参照
