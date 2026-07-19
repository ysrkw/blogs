# 2026-06-22 textlint 導入セッション

執筆ではなくツール導入の回。ideas/ drafts/ の textlint 指摘修正で記事系ファイルに触れたため reflect 対象とした。

## やったこと

- textlint + `@textlint-ja/preset-ai-writing` + `ja-technical-writing` を導入。4経路で効かせる（pnpm / lefthook / Claude hook / blog-polish）
- ideas/ drafts/ の既存指摘を本人判断で言い換え修正（config 緩和はしない方針）
- blog-ideate テンプレの `想定読了時間→読了時間の目安` を修正（伝播の根を断つ）
- lefthook glob の flat 取りこぼしバグを発見・修正、main へマージ・push

## 本人の言葉

- 「textlint のプラグイン自体が技術記事向けの校正なので、推奨の形でブログ記事を書きたかったから」（ルールを緩めず本文を直す理由）
- 「普通にルールを厳しくしたい」（no-doubled-joshi の も・や を allow で緩めない判断）

## 申し送り

- 新ルール／プリセット導入時はテンプレ（templates/\*.md）も必ず通す。テンプレ違反は全生成物に伝播する
- textlint の指摘は「推奨形への招待」。原則ルールでなく本文を直す。例外は文体と衝突する ja-no-weak-phrase のみ off
