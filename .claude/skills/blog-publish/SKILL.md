---
name: blog-publish
description: 推敲済みの下書きを公開作業として仕上げる。frontmatter確定・参考文献の整形・articles/への移動・コミット案内を行う。引数 {slug} を受け取る。「公開準備」「公開して」で発動。
---

# blog-publish

ブログ執筆ワークフローの 第4段階（最終）。
`works/{slug}/article.md` を `articles/{YYYY-MM-DD}-{slug}.md` として公開する、**リリース作業専用**のスキル。

文体・リズム・用語ブレなどの推敲は扱わない。それは `/blog-review {slug}` の役割で、このスキルを呼ぶ前に本人が推敲を満足いくまで済ませている前提で動く。

このスキルでだけ、ファイル名に日付（YYYY-MM-DD）を付与する。

生まれた経緯: `blog-polish` という名前だったが、`blog-review` の新設で推敲（機械チェック・人判断チェック）はそちらへ統合し、このスキルは公開作業だけを担うようになった。名前も「推敲」を意味する polish から `blog-publish` に改めた（2026-07-20）。

## 入力

- 引数: `{slug}`
- 読み込み: `works/{slug}/article.md`

## 進め方

1. 事前確認
   - `/blog-review {slug}` での推敲が済んでいるか本人に確認する（textlint 指摘が残っていないか、まだ磨きたい箇所がないか）
   - 済んでいなければ `/blog-review {slug}` を先に案内し、このスキルの実行はそこで止める

2. frontmatter と参考文献の最終化
   - `title`, `summary`, `tags` を確定
   - `status: published`
   - `updated` を今日に
   - `created` は ideate 時の日付を維持
   - 参考文献があれば SIST 02 スタイルに整形する。書式は「著者名（姓, 名）. 書名: 副題. 訳者名 訳. 出版者, 刊行年.」。漢字連続が textlint で出たら固有名詞のみ allow 登録・他は言い換え／スペースで対処する

3. 公開（ファイル移動）
   - 公開日を確認（今日でよいか、別日に予約するか）
   - `articles/{YYYY-MM-DD}-{slug}.md` として書き出す
   - 元の `works/{slug}/` は消さない（後で経緯を振り返る資料）

4. コミット案内
   - `docs: add article "{title}"` 等、Conventional Commits の `docs:` プレフィックスを推奨
   - コミット自体はユーザーの明示的な指示があるまで実行しない

## 重要原則

- 推敲・文体の指摘はここでしない。気づいても `/blog-review {slug}` へ差し戻す
- 「もっと良くなる」可能性は無限にある。完璧主義で公開を遅らせない判断を優先

## 次のステップ

完了後、コミット & push（`git push origin main` 等）で公開できる旨を伝える。
