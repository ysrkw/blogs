# スキル

このリポジトリのローカルスキル（`.claude/skills/`）の索引。何のためにいつ使うかだけ示す。挙動の実体は各 SKILL.md にある。

## ワークフロー

記事を公開まで運ぶ 4 段階。流れと段階の詳細は [workflow.md](./workflow.md) を参照。

| スキル       | 段階 | 用途                                              | 発動語         |
| ------------ | ---- | ------------------------------------------------- | -------------- |
| blog-ideate  | 1    | コンセプトを対話で発掘し `ideas/{slug}.md` に保存 | ネタ出し       |
| blog-outline | 2    | 構成（タイトル候補・リード方針・H2/H3）を組む     | 構成を作る     |
| blog-draft   | 3    | 本文をセクション単位で書き起こす                  | 下書き         |
| blog-polish  | 4    | 推敲して `articles/` に公開形で移す               | 推敲・公開準備 |

## 補助

ワークフロー 4 段階の外で使う。

| スキル           | 用途                                                                | 発動語              |
| ---------------- | ------------------------------------------------------------------- | ------------------- |
| blog-reflect     | セッションを振り返り書き手の癖・改善案を `docs/` に蓄積（第5段階）  | 振り返り／Stop hook |
| blog-walkthrough | 記事全体を 1 ブロックずつ通し読みし流れ・リズムを見直す。draft 以降 | 通し読み            |
| book-log         | 読んだ本を `docs/books/{slug}.md` に記録する                        | 本を読んだ          |

## 外部スキル

- humanizer: AI 臭い文章パターンを検出する。[blader/humanizer](https://github.com/blader/humanizer) を `~/.claude/skills/` に導入して使う（本リポジトリ外）。blog-draft / blog-polish から観点を借りる。未導入ならそれらの humanizer 参照箇所は手動チェックで代替する

humanizer / textlint は丸ごと当てない。運用原則は [writing-policy.md](./writing-policy.md)「AI の執筆姿勢」を参照。
