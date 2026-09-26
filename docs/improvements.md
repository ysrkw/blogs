# improvements

blog システム全体への改善提案ログ。対象はスキル（blog-\*）に限らない。

- スキル（`.claude/skills/**/SKILL.md`）
- ドキュメント（`docs/writing-policy.md` / `docs/structure.md` / `docs/templates.md` など）
- ワークフロー・命名規則・運用ルール
- **振り返りの仕組みそのもの**（retrospective / notes の構造）

「どのスキルを直すか」ではなく「次のセッションが楽になるよう、この blog システムのどこを変えるとよいか」を溜める場所。各提案は対象ファイルを明記する。
`/retrospective` が追記する。

**この一覧に載るのは未適用の提案だけ**。ステータスのフラグは持たない。ユーザーが採用と判断したらその場で対象ファイルを編集し、この項目を削除する。却下したときも項目を削除する。採否とその理由は commit メッセージに書き、経緯は git 履歴で辿る。

## 提案ログ

1 項目の書き方は [templates.md](./templates.md)「改善提案ログの項目」を参照。

### 2026-07-28: docs/templates.md - 回を重ねる記録ファイルの見出し規約を一般化する

- 対象: `docs/templates.md`、`.claude/skills/retrospective/SKILL.md`（session-logs の雛形）
- 背景: review.md が MD024（見出しの重複）に当たり、回ごとの節を `## YYYY-MM-DD` で積み、中のラベルを H3 でなくリード文にする形へ直した。同じ問題は session-logs にもある。今日は同じ slug で2セッション走った。既存ファイルへ追記すると H2 が重複するため、`-2` を付けた別ファイルにした
- 変更案: 回を重ねて追記する記録（review.md・振り返りメモ）の見出し規約を、templates.md に1節として立てる。review.md と session-logs の雛形からはそこを参照させる。session-logs は1セッション1ファイルのままとし、同日2回目のファイル名規則（`-2` など）を明記する
- 期待される効果: 次に別の記録ファイルを足すときも同じ罠を踏まない。lint を緩める判断が再発しない
