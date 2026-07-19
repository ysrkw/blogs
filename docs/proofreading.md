# 校正: textlint

文章校正は [textlint](https://github.com/textlint/textlint) で機械チェックする。プリセットは 2 つ。AI 臭を検出する [ai-writing プリセット](https://github.com/textlint-ja/textlint-rule-preset-ai-writing) と、日本語の技術文の作法をみる [ja-technical-writing プリセット](https://github.com/textlint-ja/textlint-rule-preset-ja-technical-writing) を使う。設定は `.textlintrc.json`。対象は `node_modules/` を除く全 Markdown（除外は `.textlintignore` で管理）。ルールはほぼ厳格運用。カジュアルな文体と両立しない `ja-no-weak-phrase`（「思います」等）だけ off にし、疑問符 `？` は許可している。

次の経路で効く。

- `pnpm textlint` / `pnpm textlint:fix`: 手動実行
- pre-commit hook（lefthook）: ステージした `*.md` を検査
- Claude Code hook（PostToolUse）: Claude が `*.md` を編集すると textlint が走る。指摘は Claude に差し戻す（`.claude/hooks/textlint-on-edit.sh`）
- `/blog-polish`: 推敲の最初に `pnpm textlint` をかけ、観点別チェックの材料にする

humanizer 同様、**丸ごと `--fix` を当てて書き換えない**。指摘を 1 つずつ本人判断で反映し、文体・語りを守るため当てない指摘も選んでよい。運用原則の全体は CLAUDE.md「AI の執筆姿勢」を参照。
