# 校正: textlint / markdownlint

Markdown の自動チェックは 2 つのツールで役割を分ける。日本語の文章は textlint、Markdown の構文は markdownlint が担当する。書き方の規約（人間向け）は [markdown-style.md](./markdown-style.md) を参照。

## textlint（文章校正）

文章校正は [textlint](https://github.com/textlint/textlint) で機械チェックする。プリセットは 2 つ。AI 臭を検出する [ai-writing プリセット](https://github.com/textlint-ja/textlint-rule-preset-ai-writing) と、日本語の技術文の作法をみる [ja-technical-writing プリセット](https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing) を使う。設定は `.textlintrc.json`。対象は `node_modules/` を除く全 Markdown（除外は `.textlintignore` で管理）。ルールはほぼ厳格運用。カジュアルな文体と両立しない `ja-no-weak-phrase`（「思います」等）だけ off にし、疑問符 `？` は許可している。

次の経路で効く。

- `pnpm textlint` / `pnpm textlint:fix`: 手動実行
- pre-commit hook（lefthook）: ステージした `*.md` を検査
- Claude Code hook（PostToolUse）: Claude が `*.md` を編集すると textlint が走る。指摘は Claude に差し戻す（`.claude/hooks/textlint-on-edit.sh`）
- `/blog-polish`: 推敲の最初に `pnpm textlint` をかけ、観点別チェックの材料にする

humanizer 同様、**丸ごと `--fix` を当てて書き換えない**。指摘を 1 つずつ本人判断で反映し、文体・語りを守るため当てない指摘も選んでよい。運用原則の全体は CLAUDE.md「AI の執筆姿勢」を参照。

## markdownlint（構文チェック）

Markdown の構文（見出し周りの空行・リストの体裁・末尾空白など）は [markdownlint-cli2](https://github.com/DavidAnson/markdownlint-cli2) で検査する。textlint が日本語の文章を、markdownlint が Markdown の構文をみる、という役割分担。設定は root の `.markdownlint-cli2.jsonc`。対象は `node_modules/` を除く全 Markdown。

次の経路で効く。

- `pnpm markdownlint`: 手動実行。機械的な修正は `pnpm markdownlint:fix`
- pre-commit hook（lefthook）: ステージした `*.md` を検査
- Claude Code hook（PostToolUse）: Claude が `*.md` を編集すると markdownlint が走る。指摘は Claude に差し戻す（`.claude/hooks/markdownlint-on-edit.sh`）

主なルール調整（理由は設定ファイルのコメントを参照）。

- `MD013`（行長）は無効。日本語の長い段落があるため
- `MD009`（末尾空白）は半角スペース 2 つを許可。改行を行末スペース 2 つで表す規約（[markdown-style.md](./markdown-style.md)）に合わせるため
- `MD025` は frontmatter の `title` を H1 と数えない。記事は frontmatter title と本文冒頭 H1 を両方持つため
- `MD028`（引用ブロック間の空行）・`MD029`（順序リストの番号）は無効。振り返りメモ・スキルの書き方に合わせるため

markdownlint の指摘は機械的な構文が中心だが、textlint と揃えて Claude Code hook では丸ごと `--fix` せず差し戻す。機械的にまとめて直したいときは `pnpm markdownlint:fix` を手動で走らせる。
