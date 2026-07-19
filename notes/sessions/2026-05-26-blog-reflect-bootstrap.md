---
date: 2026-05-26
slug: blog-reflect-bootstrap
stage: meta
---

# 2026-05-26 blog-reflect-bootstrap

## このセッションでやったこと

- ワークフローに「セッションを振り返り、ナレッジ化する」段階が無い問題に気づき、第5段階として
  `/blog-reflect` を新設
- `knowledge/`（writing-style / process-notes / skill-improvements / sessions）を設計
- Stop hook で `ideas/ drafts/ articles/` 更新があったセッション終了時に自動で振り返りを促す仕組みを追加
- skill-improvements.md は「提案ログ → ユーザー判断で適用」の二段構えに分離

## 設計判断と理由

- **AI が SKILL.md を直接書き換えない**ことを最初に固めた。理由: 書き手代替を避ける CLAUDE.md の原則と
  同じ温度感を、スキル自己改善にも適用したいから
- **記事ファイルには触らない**ことを SKILL に明記。振り返りと推敲（polish）を混ぜないため
- Stop hook は「触ったら止める」ではなく「触ったら促す」に留めた。`decision: block` + reason で
  Claude を継続させる方式。スキップ判断は `.reflect-state` の touch で表現する設計
- 初回起動の扱いに迷ったが、「既存 .md があれば促す、無ければ state を初期化して通す」とした

## 次回への申し送り

- 実際に記事を書いた次セッションで `/blog-reflect` を一度通して、ヒアリング 4 問が冗長か／不足かを判定する
- skill-improvements.md は当面空のまま運用し、提案が積まれるパターンを観察する
