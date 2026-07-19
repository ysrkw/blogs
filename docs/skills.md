# 補助スキル

ワークフロー 4 段階（[workflow.md](./workflow.md)）の外で使う補助スキルの説明。

## blog-walkthrough（通し読み）

記事全体を冒頭から 1 ブロックずつ通し読みして見直すスキル。セクション単位の往復では見えない、全体の流れを確認する。「通し読み」や `/blog-walkthrough {slug}` で発動する。draft 以降ならどの段階にも使える。

- 指摘・質問は 1 回につき 1 件だけ。回答の負荷を下げるための原則
- 観点は前後のつながり・リズム・見出しと本文の対応・比喩の一貫性・リードとまとめの呼応
- リズムは両方向で見る。意図的な言い切りは揃えず、平坦な文体には抑揚を提案する

## humanizer

AI 臭い文章のパターンを検出するスキルとして [`humanizer`](https://github.com/blader/humanizer) を使う。置き場所はユーザー領域の `~/.claude/skills/humanizer/`。検出するのはダッシュの多用・機械的な太字・三点強調・アフォリズム化など（Wikipedia「Signs of AI writing」ベース）。blog-draft（書く時点）と blog-polish（推敲時）から観点を借りて使う。

- **全文リライト型なので丸ごとは当てない**。検出項目を 1 つずつ本人判断で反映する（一次体験・語りを削らないため）
- セットアップ: [blader/humanizer](https://github.com/blader/humanizer) をユーザーの `~/.claude/skills/` に導入しておく（このリポジトリには含まれない）。未導入なら blog-draft / blog-polish の humanizer 参照箇所は手動チェックで代替する

## book-log

読んだ本を記録するスキル。「本を読んだ」と報告したら発動する。書誌（原題・訳者・出版社・刊行年・ISBN）を一次情報から取得する。概要を下書きし、使いどころは本人にヒアリングする。そのうえで `knowledge/books/{slug}.md` を作り、索引 `knowledge/books.md` に1行追加する。ワークフローの外で、記事の参考文献や根拠を再利用しやすくするのが目的。

- 1冊につき1ファイル。索引は `knowledge/books.md` がリンク一覧と運用ルールを持つ
- 書誌は AI の記憶で埋めず、出版社ページや CiNii など一次情報で裏取りする
