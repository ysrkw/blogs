---
name: blog-publish
description: 推敲済みの下書きを公開作業として仕上げる。frontmatter確定・参考文献の整形・articles/への移動・コミット案内を行う。引数 {slug} を受け取る。「公開準備」「公開して」で発動。
argument-hint: "{slug}"
allowed-tools:
  - Read
  - Write
---

# blog-publish

ブログ執筆ワークフローの 第4段階（最終）。
`works/{slug}/article.md` を `articles/{YYYY-MM-DD}-{slug}.md` として公開する、**リリース作業専用**のスキル。

文体・リズムの推敲、内容の客観チェックは扱わない。それぞれ `/blog-writing` の通し読みモード、`/blog-review {slug}` の役割で、このスキルを呼ぶ前に本人がどちらも満足いくまで済ませている前提で動く。

このスキルでだけ、ファイル名に日付（YYYY-MM-DD）を付与する。

## 目指すゴール

推敲・客観チェックが済んだ記事を、公開作業（frontmatter 確定・参考文献の整形・ファイル移動・コミット案内）だけに専念して仕上げる。文体や内容への指摘はここでしない。「もっと良くなる」可能性を追いかけて公開を遅らせるより、区切りをつけて外に出すことを優先する。

## 入力

- 引数: `{slug}`
- 読み込み: `works/{slug}/article.md`

## 進め方

1. 事前確認
   - `/blog-writing {slug}` の通し読みモードでの推敲、`/blog-review {slug}` での客観チェックが済んでいるか本人に確認する
   - textlint 指摘が残っていないか、まだ磨きたい箇所や見送った指摘が残っていないかも併せて確認する
   - 済んでいなければ該当するスキルを先に案内し、このスキルの実行はそこで止める

2. frontmatter と参考文献の最終化
   - `title`, `summary`, `tags` を確定
   - `status: published`
   - `updated` を今日に
   - `created` は `article.md` を最初に作成した日を維持
   - 参考文献があれば SIST 02 スタイルに整形する。書式は「著者名（姓, 名）. 書名: 副題. 訳者名 訳. 出版者, 刊行年.」。漢字連続が textlint で出たら固有名詞のみ allow 登録・他は言い換え／スペースで対処する

3. 公開（ファイル移動）
   - 公開日を確認（今日でよいか、別日に予約するか）
   - `articles/{YYYY-MM-DD}-{slug}.md` として書き出す
   - 元の `works/{slug}/` は消さない（後で経緯を振り返る資料）

4. コミット案内
   - `docs: add article "{title}"` 等、Conventional Commits の `docs:` プレフィックスを推奨
   - コミット自体はユーザーの明示的な指示があるまで実行しない

## 重要原則

- 推敲・文体・内容の指摘はここでしない。気づいても `/blog-writing {slug}` または `/blog-review {slug}` へ差し戻す
- 「もっと良くなる」可能性は無限にある。完璧主義で公開を遅らせない判断を優先

## 次のステップ

完了後、コミット & push（`git push origin main` 等）で公開できる旨を伝える。
