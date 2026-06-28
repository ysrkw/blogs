# books

記事で参照した／背景に読んだ本のストック（索引）。参考文献や根拠の再利用に使う。
本ごとの詳細は `books/{slug}.md` に分割。このファイルはリンク索引と運用ルールだけを持つ。

## 運用ルール

- **ユーザーが「本を読んだ」と報告したら、`books/{slug}.md` を新規作成し、この索引にも 1 行追加する**
- 1 ファイルの記録項目は 書名・著者／概要／使いどころ／書誌（参考文献用）／記事で引いた対応・キーアイデア／登場記事
- 「使いどころ」には、その本をどういうテーマ・文脈で記事に使いたいかという本人の意図メモを書く。まだ使っていなくても書いておく
- 「書誌（参考文献用）」には、原題・訳者・出版社・刊行年・ISBN などを記事作成時に WebFetch し直さなくて済むよう事前に取得して書く。値は出版社ページや CiNii など一次情報で裏取りする
- 概要は読んだ実感で補正していく。AI の下書きは「（要確認）」を付け、本人確認で外す
- AI の知識ベースで書いた概要は事実誤認がありうる。本人の補正を優先する

## 一覧

- [UNIXという考え方](books/unix-philosophy.md) — 最古の SaaS／小さな道具を組み合わせる哲学。使いどころメモあり・記事未使用
- [ハッカーと画家](books/hackers-and-painters.md) — 最古の SaaS の例（Viaweb の Web デプロイ・サポートの速さ）。使いどころメモあり・記事未使用
- [HIGH OUTPUT MANAGEMENT](books/high-output-management.md) — マネージャーのアウトプット＝チームの総和、レバレッジ。登場: organization-as-software（核）
- [チームトポロジー](books/team-topologies.md) — 認知負荷を軸にしたチーム設計。登場: organization-as-software（核）
- [EMPOWERED](books/empowered.md) — 権限を持つプロダクトチーム。登場: organization-as-software（参考文献）
- [エンジニアリングマネジャー入門](books/engineering-management-for-the-rest-of-us.md) — エンジニア出身者向けの EM 入門。登場: organization-as-software（参考文献）
- [ビジョナリー・カンパニー2](books/good-to-great.md) — good から great への飛躍の法則。第 5 水準のリーダーは目的と意思決定を備えた普通の人。使いどころメモあり・記事未使用
- [SCRUM BOOT CAMP THE BOOK【増補改訂版】](books/scrum-boot-camp.md) — スクラム入門。チームが話し合って製品を良くする努力。使いどころメモあり・記事未使用
- [人が壊れるマネジメント](books/human-breaking-management-50.md) — プロジェクトで人が壊れる 50 のアンチパターン。停滞のストレスと小さな前進の実感。使いどころメモあり・記事未使用
- [達人に学ぶSQL徹底指南書 第2版](books/sql-tettei-shinansho.md) — 集合指向で SQL を書くための考え方（CASE 式・ウィンドウ関数など）。SQL のパフォーマンスや設計の話で出すアドバイス用。使いどころメモあり・記事未使用
- [達人に学ぶDB設計 徹底指南書 第2版](books/db-sekkei-tettei-shinansho.md) — 論理設計と物理設計から DB 設計を体系化。正規化・ER 図・バッドノウハウなど。DB 設計の解説回のアドバイス用。使いどころメモあり・記事未使用
- [単体テストの考え方/使い方](books/unit-testing-principles-practices-and-patterns.md) — 良いテストを 4 本柱（退行からの保護・リファクタリング耐性・速いフィードバック・保守性）で評価。AI が書くテストの質を語る軸に。使いどころメモあり・記事未使用
- [改訂新版 良いコード／悪いコードで学ぶ設計入門](books/good-code-bad-code.md) — 悪い構造の認識から名前・クラス設計・リファクタリングまで段階的に学ぶ設計入門。AI が書くコードの設計品質を語る軸に。使いどころメモあり・記事未使用
- [悲劇的なデザイン](books/tragic-design.md) — デザインが人を傷つける 4 類型を事例で検証。UI による人災・デザインが人を殺すという話に。使いどころメモあり・記事未使用
