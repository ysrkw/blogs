# 記事テンプレート

ブログ記事に関するテンプレートを種類ごとに見出しで分ける。テンプレが増えたらここに節を足し、大きくなったら `templates/` ディレクトリへ分割する。

## 記事 frontmatter スキーマ

記事ファイル（`ideas/`・`drafts/`・`articles/`）の frontmatter はこのスキーマを正規とする。各段階のスキル（`/blog-ideate`・`/blog-outline`・`/blog-draft`・`/blog-polish`）が出力する雛形の frontmatter 部分はここに従う。フィールドの意味を各スキルで再定義しない。

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
