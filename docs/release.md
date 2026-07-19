# リリース手順（Qiita への公開）

公開先は [Qiita の ysrkw アカウント](https://qiita.com/ysrkw)。公開処理は手動で行う。

1. `/blog-polish` を完了し、`articles/{YYYY-MM-DD}-{slug}.md` を作る
   - frontmatter は `status: published`、ファイル名にはこの時点で日付を付与する
2. Qiita の投稿画面に本文を貼り付けて公開する
   - frontmatter は Qiita に載せない。タイトル・タグは Qiita 側の入力欄で設定する
   - 過去記事へのリンクは、リポジトリ内の相対パスではなく Qiita の公開 URL に張る
3. 公開後、公開 URL を記事 frontmatter の `published_url` に記録してコミット・プッシュする
   - 公開済み記事を修正するとき、すぐ公開先を参照できるようにする
4. [README.md](../README.md) の「記事」一覧に、タイトルから `articles/{YYYY-MM-DD}-{slug}.md`（GitHub 上のマークダウン）へのリンクを1行足す（新しいものを下に並べる）

## 未決事項

- 公開済み記事の `ideas/{slug}.md` や `drafts/{slug}/` をファイルとして残すか（2026-07-19 時点で未決）
  - 過程の記録として残す案と、公開後は削除して `articles/` へ一本化する案がある
