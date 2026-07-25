# リリース手順（Qiita への公開・更新）

公開先は [Qiita の ysrkw アカウント](https://qiita.com/ysrkw)。公開処理は手動で行う。

`articles/` を現在公開している内容の正本、`works/` を次の改稿を進める作業場とする。公開後も `works/{slug}/` は執筆履歴と改稿のために残す。過去の公開版は Git 履歴で追跡する。

## 新規公開

1. `/blog-writing` の通し読みモードでの推敲、`/blog-review` での客観チェックを済ませる。そのうえで `/blog-publish` を完了し、`articles/{YYYY-MM-DD}-{slug}.md` を作る
   - frontmatter は `status: published`、ファイル名にはこの時点で日付を付与する
2. Qiita の投稿画面に本文を貼り付けて公開する
   - frontmatter は Qiita に載せない。タイトル・タグは Qiita 側の入力欄で設定する
   - 過去記事へのリンクは、リポジトリ内の相対パスではなく Qiita の公開 URL に張る
3. 公開後、公開 URL を記事 frontmatter の `published_url` に記録してコミット・プッシュする
   - 公開済み記事を修正するとき、すぐ公開先を参照できるようにする
4. [README.md](../README.md) の「記事」一覧に、タイトルから `articles/{YYYY-MM-DD}-{slug}.md`（GitHub 上のマークダウン）へのリンクを1行足す（新しいものを下に並べる）

## 公開後の軽微な修正

誤字、リンク切れ、事実関係の小さな訂正など、記事の構成や主張を再検討しない修正は `articles/{公開日}-{slug}.md` に直接反映する。

1. `articles/` の記事を修正し、frontmatter の `updated` を修正日に更新する
2. textlint と markdownlint を通す
3. Qiita 側へ同じ修正を反映する
4. 修正内容をコミットする

ファイル名の日付は初回公開日のまま維持する。README の記事一覧も追加し直さない。

## 公開後の内容改稿

構成、主張、説明を再検討する修正は `works/{slug}/article.md` を作業場として通常の推敲・レビューを通す。

1. `articles/` の公開版を正本として、本文と frontmatter を `works/{slug}/article.md` に取り込む
   - `works` 側は `status: draft` にする
   - `created` は既存の `article.md` の値を維持し、`updated` を改稿開始日に更新する
2. `/blog-writing` で推敲する
3. `/blog-review` で内容を再確認する
4. `/blog-publish` で既存の `articles/{初回公開日}-{slug}.md` を更新する
   - `status: published` に戻し、`updated` を更新日にする
   - `published_url` は維持する
5. Qiita 側へ改稿内容を反映し、コミットする

改稿でもファイル名の日付は初回公開日のまま維持する。更新日は frontmatter の `updated` で記録し、README の記事一覧も追加し直さない。
