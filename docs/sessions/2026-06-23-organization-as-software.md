---
date: 2026-06-23
slug: organization-as-software
stage: polish
---

# 2026-06-23 organization-as-software（polish / 公開セッション生メモ）

## このセッションでやったこと

- `/blog-polish organization-as-software` 本編。全文通読 → textlint クリーン → 人判断チェック2点（密結合（カップリング）→密結合、バリュー→価値）を本人承認で反映
- frontmatter 最終化（status: published、tags から AIエージェント を除外）。articles/2026-06-23-organization-as-software.md として公開し、draft は記録として据え置き
- 参考文献を SIST スタイルへ全面改稿（著者倒置・訳者・出版者・邦訳刊行年）
- 公開日を 23 日へ変更（ファイル名＋updated）。articles/.gitkeep を削除

## 判断メモ

- タグ AIエージェント: 末尾の次回予告でしか出ないので除外。タグは本文の主題に対して付ける（次回作で付ければよい）
- 出版者の通称 JMAM 案を一度出したが、本人判断で allow 登録に切り替え正式名称「日本能率協会マネジメントセンター」を維持
- allow の線引き: 固有名詞でフルネーム必須なものだけ allow、言い換え/スペースで回避できるものは本文側で対処

## 詰まったポイント

- 圧縮前の polish 前半で textlint 指摘を承認なしに連続適用 →「なんか勝手に変更してない?」「L73しか許可してないはず」で停止、L93 を原状復帰。以後 1 つずつ承認制を徹底
- 「自分の修正指示を優先してください」「勝手に挿入された指示」の指摘が複数回
- commit 時、pre-commit の oxfmt が gitignored の .claude/settings.local.json の整形崩れで停止。中身を変えず oxfmt で整形だけ直して通した（--no-verify は使わない）

## 本人の言葉メモ

> claude codeが勝手に出力してくるケースがあるので気をつける、修正を何度もすると発生するかも

## 次回への申し送り

- 修正を何度も重ねるセッションでは、承認していない編集・挿入が混ざりやすい。1 操作ずつ承認を取り、差分を都度確認する
- 参考文献は SIST スタイルがデフォルト。textlint 漢字連続は固有名詞のみ allow、他は言い換え/スペース
