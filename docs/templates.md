# テンプレート

リポジトリで使うテンプレートを種類ごとに見出しで分ける。テンプレが増えたらここに節を足し、大きくなったら `templates/` ディレクトリへ分割する。

## 記事 frontmatter スキーマ

記事ファイル（`works/`・`articles/`）の frontmatter はこのスキーマを正規とする。各段階のスキル（`/blog-ideate`・`/blog-outline`・`/blog-writing`・`/blog-publish`）が出力する雛形の frontmatter 部分はここに従う。フィールドの意味を各スキルで再定義しない。

```yaml
---
title: # 公開タイトル
slug: # kebab-case-title
status: idea | outline | draft | published
created: YYYY-MM-DD # ideate 時に確定
updated: YYYY-MM-DD # 更新の都度
tags: [] # draft 以降で付与
summary: # 1〜2 行の要約。draft 以降で付与
published_url: # Qiita の公開 URL。公開後に記録
---
```

- `status` は段階に応じて `idea → outline → draft → published` と進む
- `tags` / `summary` は outline 段階では省略してよい。draft 以降で埋める
- `published_url` は publish 後にのみ付く（手順は [release.md](./release.md)）
- 本文は frontmatter 直後に `# {title}`（`title` と同じ文言の H1）を置いてから書き始める。H1 の下に 1 行空けてリード文を続ける

## 改善提案ログの項目

`docs/improvements.md` に 1 提案を追記するときの雛形。`/retrospective` の第4ステップが使う。

```markdown
### YYYY-MM-DD: {対象} - 一行要約

- 対象: 書き換えるファイル（例: blog-outline の SKILL.md / docs/structure.md / ワークフロー）
- 背景: このセッションで何が起きたか（具体的に）
- 変更案: どの章をどう書き換えるか（before/after の抜粋）
- 期待される効果: 次のセッションで何が良くなるか
```
