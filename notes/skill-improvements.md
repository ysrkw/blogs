# skill-improvements

既存スキル（blog-ideate / blog-outline / blog-draft / blog-polish / blog-reflect）への改善提案ログ。
`/blog-reflect` が追記する。**ユーザー判断で `applied` に変えてから** SKILL.md を編集する。
反映済み（`applied`）・廃止（`superseded`）の項目は反映後に削除し、ここには未適用（`proposed`）だけを残す。経緯は git 履歴で辿れる。

## ステータス

- `proposed`: AI が提案、未適用
- `applied`: SKILL.md に反映済み（反映後この一覧からは削除）
- `rejected`: 採用しない判断をした（理由を残す）

## 提案ログ

<!--
### YYYY-MM-DD: blog-{name} - 一行要約

- status: proposed
- 背景: どのセッションで何が起きたか
- 変更案: SKILL.md のどの章をどう書き換えるか
- 期待される効果: 次の記事で何が良くなるか
-->

### 2026-07-12: book-log - 動画など本以外の参照ソースも記録できるようにする

- status: proposed
- 背景: critical-thinking-with-coding-agents の draft で「知性とは情報の圧縮」の出典に YouTube 動画を使った。3Blue1BrownJapan「エントロピーの再発明 | 圧縮と知能 Part 1」を記事にリンクした形。本人発言「動画の引用も本のように今後記録したりやりやすくできると良いかも」。現状の book-log は書籍専用で、動画・Web 記事の記録先が無い
- 変更案（いずれか、本人判断待ち）:
  - (a) book-log を「ソースログ」に一般化。`books/` を本・動画・記事が同居する形に広げ、索引も統合する。書誌の取得元（oEmbed / 書誌 DB）だけ種別で分岐
  - (b) 動画用に並行スキルを作る。`videos/{slug}.md` ＋索引。book-log の構造を踏襲（タイトル・チャンネル・URL・概要・使いどころ）
  - (c) 軽量案。スキル化せず `references.md` に1行形式（タイトル／作者／URL／関連トピック）で貯める。件数が増えたら (a)(b) に育てる
- 判断メモ: YouTube は oEmbed（`https://www.youtube.com/oembed?url=...`）でタイトル・チャンネル名を機械取得できることを今回確認済み。書誌を一次情報から取得するのと同じ流れが作れる
- 追記（2026-07-12 同日）: 同セッション内で Web 記事・論文の引用も発生した。「LLM は増幅器」の出典を Web 検索で探し、arXiv 論文（AI as Equalizer or Amplifier?）を記事にリンクした。本人発言「Web の記事も引用したい場合の機能が欲しいね」。動画に限らず Web ソース全般を扱える (a) または (c) の方向が本人ニーズに合いそう
- 期待される効果: 記事で断定に出典を添えるとき、過去に観た動画を探し直さずに済む。「使いどころ」を記録しておけば draft 中の根拠探しが速くなる

### 2026-07-12: blog-draft - textlint の機械的指摘は AI が先に直してまとめて報告する

- status: proposed
- 背景: critical-thinking-with-coding-agents の draft で、textlint 指摘のたびに選択肢を出して確認する往復が5回発生した。本人言「ルールによっては先に対応しちゃっても良い」（最終的に全文を見ながらフィードバックする場を設けているため）
- 変更案: SKILL.md「進め方 / 3.」に追記する。合意済み本文の反映時に出た textlint 指摘のうち、意味を変えない機械的な言い換え（助詞重複・文長分割・受動表現など）は AI が直して差分を報告のみとする。意味やニュアンスに触れる指摘（語彙の変更・文の削除）は従来どおり選択肢で確認する
- 期待される効果: draft の往復が軽くなり、書く流れが途切れない。最終確認は polish の全文チェックで担保する
