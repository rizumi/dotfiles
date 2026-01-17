---
description: 現在のgit変更とタスクを把握して全エージェントで並列レビューする
argument-hint: [base-branch（デフォルト: main）]
---

現在の作業状況を把握してレビューを実行します。

ベースブランチ: ${1:-main}

## 実行内容

1. **現在の状況把握**
   - `git status` で変更されたファイルを確認
   - `git diff` で具体的な変更内容を確認
   - `git log` で最近のコミット履歴を確認

2. **並列レビュー実行**
   - **naming-convention-checker** - 新しい変数名・関数名をチェック
   - **architecture-reviewer** - 変更がアーキテクチャに与える影響を評価
   - **performance-reviewer** - 変更によるパフォーマンス影響を分析
   - **security-reviewer** - 変更によるセキュリティリスクを検査
   - **documentation-reviewer** - ドキュメント・コメントの品質をチェック

3. **統合レポート**
   - 各エージェントの結果をまとめて優先度付き改善提案を作成
   - コミット前に対処すべき問題を明確化