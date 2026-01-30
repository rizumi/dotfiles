---
name: pr-create
description: Create a pull request with predefined template
allowed-tools: Read, Glob, Bash(git:*), Bash(gh:*), AskUserQuestion
disable-model-invocation: true
user-invocable: true
---

# PR作成スキル

プロジェクトのPRテンプレートに従ってPull Requestを作成します。

## 手順

1. 以下のコマンドを並列実行して現在の状態を確認:
   - `git status` で未コミットの変更を確認
   - `git log origin/main..HEAD --oneline` でコミット一覧を取得
   - `git diff origin/main..HEAD --stat` で変更ファイルの概要を取得
   - ※ デフォルトブランチが `master` の場合は適宜読み替える

2. PRテンプレート（`.github/pull_request_template.md`）を読み込む

3. 変更内容を分析し、テンプレートに沿ってPR本文を作成

4. ユーザーにdraft PRとして作成するか確認

5. PRを作成:
   ```bash
   gh pr create [--draft] --assignee @me --title "PRタイトル" --body "PR本文"
   ```

## 注意事項

- PRタイトルはConventional Commits形式を推奨（例: `feat(UI): 新機能追加`）
- PRタイトルは必ず日本語で付けること
- `--assignee @me` で自分をAssigneeに設定
- PR本文はHEREDOCを使用してフォーマットを保持
- 動作確認項目を記載する場合はチェックボックスを用いる
- **baseブランチがデフォルトブランチ以外の場合**: 概要の先頭に `on: #<親PRの番号>` を記載して、どのPRに連なっているかを明示する
  - 例: `--base feature/parent-branch` の場合、そのブランチのPR番号を `gh pr list` 等で確認し、概要に `on: #123` のように記載
- PR本文の末尾に必ず以下を追記:
  ```
  ---
  🤖 Generated with [Claude Code](https://claude.ai/code)
  ```
