---
name: git-commit
description: Create well-formatted git commits with clear, standalone commit messages following Conventional Commits format. Use this skill when the user explicitly requests to create a git commit or use phrases like "commit these changes", "make a commit", "commit this", or similar commit-related requests. This skill ensures commit messages are self-explanatory and prevents accidental commits.
allowed-tools: Read, Bash(git:*), AskUserQuestion
---

# Git Commit

## Overview

このスキルは、明確で自己完結した commit メッセージを持つ git commit を作成します。Conventional Commits 形式に従い、ユーザーの明示的な承認を得てから commit を実行することで、意図しない commit を防ぎます。

## 重要な原則

1. **明確な commit メッセージ**: commit メッセージは、その commit 単体で何が変更されたかが理解できる必要があります
   - ❌ 悪い例: "fix review", "update", "WIP"
   - ✅ 良い例: "fix: Resolve null pointer exception in user profile", "feat: Add dark mode toggle to settings"

2. **明示的な承認**: ユーザーが明示的に commit を要求した場合のみ実行します
   - ユーザーが「commit して」「commit を作成して」などと明示的に指示した場合のみこのスキルを使用
   - 自動的に commit を作成しない

3. **Conventional Commits 形式**: 以下のプレフィックスを使用します
   - `feat:` - 新機能の追加
   - `fix:` - バグ修正
   - `refactor:` - リファクタリング（機能変更なし）
   - `docs:` - ドキュメントのみの変更
   - `test:` - テストの追加・修正
   - `chore:` - ビルドプロセスやツールの変更
   - `style:` - コードフォーマットのみの変更（機能変更なし）
   - `perf:` - パフォーマンス改善

## Workflow

### Step 1: 変更内容の確認

まず、staged されたファイルと変更内容を確認します。

```bash
# Staged ファイルの確認
git status

# 変更内容の詳細確認
git diff --staged
```

### Step 2: 変更内容の分析と要約

変更内容を分析し、以下を特定します：

1. **変更の種類**: feat, fix, refactor, docs, test, chore, style, perf のいずれか
2. **変更の範囲**: どのモジュール/機能が影響を受けるか
3. **変更の理由と目的**: なぜこの変更が必要だったか

### Step 3: Commit メッセージの作成

Conventional Commits 形式で commit メッセージを作成します：

**フォーマット:**
```
<type>: <summary>

<optional body>

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Summary の書き方:**
- 50文字以内を目指す
- 命令形で記述（"Add" ではなく "Added" ではなく "Add"）
- 変更の「何を」「なぜ」が明確になるように記述
- commit 単体で理解できる内容にする

**Body（オプション）:**
- 変更の詳細な説明が必要な場合のみ追加
- 「なぜ」この変更が必要だったかを説明
- 複数の変更がある場合は箇条書きで列挙

**例:**
```
feat: Add dark mode support to user interface

- Implement theme provider with light/dark modes
- Add toggle switch in settings screen
- Update all components to respect theme preference
```

```
fix: Resolve memory leak in image cache

The image cache retained references after images were cleared,
causing memory usage to grow indefinitely. Updated cache to
use weak references for better memory management.
```

```
perf: Optimize database query for user search

Replace N+1 query with single JOIN operation, reducing
search time from 2s to 200ms for 10k users.
```

### Step 4: ユーザーへの確認

作成した commit メッセージをユーザーに提示し、承認を求めます：

1. Staged ファイルの一覧を表示
2. 変更内容の要約を表示
3. 作成した commit メッセージを表示
4. ユーザーに承認を求める

**確認メッセージの例:**
```
以下の変更を commit します：

Staged files:
- src/components/ThemeProvider.tsx
- src/components/Settings.tsx
- src/styles/theme.ts

変更内容:
ダークモード機能を追加し、設定画面にトグルスイッチを実装しました。

Commit メッセージ:
feat: Add dark mode support to user interface

- Implement theme provider with light/dark modes
- Add toggle switch in settings screen
- Update all components to respect theme preference

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>

この内容で commit してよろしいですか？
```

### Step 5: Commit の実行

ユーザーの承認を得た後、commit を実行します：

```bash
git commit -m "$(cat <<'EOF'
feat: Add dark mode support to user interface

- Implement theme provider with light/dark modes
- Add toggle switch in settings screen
- Update all components to respect theme preference

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
EOF
)"
```

**重要な注意事項:**
- HEREDOC を使用して commit メッセージを渡す
- 必ず `Co-Authored-By` を含める
- commit 後に `git status` で成功を確認

### Step 6: 結果の確認

Commit 実行後、結果を確認します：

```bash
git status
git log -1
```

ユーザーに commit が成功したことを報告します。

## チェックリスト

各 commit 前に以下を確認してください：

- [ ] Staged ファイルに意図しないファイルが含まれていないか
- [ ] Commit メッセージが Conventional Commits 形式に従っているか
- [ ] Commit メッセージが単体で理解できる内容か（"fix review" のような不明確なメッセージになっていないか）
- [ ] 変更の種類（feat, fix, など）が適切か
- [ ] ユーザーが明示的に commit を承認したか
- [ ] `Co-Authored-By` が含まれているか

## よくある間違いと対処法

### ❌ 曖昧な commit メッセージ
```
fix: Fix review comments
update: Update settings
refactor: Refactor code
```

### ✅ 明確な commit メッセージ
```
fix: Resolve null pointer exception in user profile rendering
feat: Add email validation to registration form
refactor: Extract authentication logic into separate service
```

### ❌ 複数の無関係な変更を1つの commit に
```
feat: Add dark mode and fix login bug
```

### ✅ 変更ごとに分割
```
feat: Add dark mode support to user interface
```
```
fix: Resolve authentication timeout on slow connections
```

### ❌ 自動的に commit を作成
ユーザー: "この変更を完了しました"
アシスタント: [自動的に commit を作成] ← これは NG

### ✅ 明示的な承認を得る
ユーザー: "commit を作成して"
アシスタント: [変更内容を確認し、commit メッセージを提案し、承認を求める]
