---
name: swift-format
description: Swift公式のformatツールを使用してSwiftコードをフォーマットするスキル。コードを書き終わった後、ファイルやプロジェクト全体のSwiftコードをフォーマットする必要がある場合に使用します。特定のプロジェクトに依存しない汎用的な構成で、.swift-formatファイルが存在しない場合はデフォルト設定を使用できます。
---

# Swift Format

## Overview

このスキルは、Swift公式の`swift format`ツールを使用してSwiftコードを自動フォーマットします。コードを書き終わった後に実行し、一貫したコードスタイルを維持します。

## Quick Start

### 単一ファイルのフォーマット

```bash
swift format --in-place <file-path>
```

例：
```bash
swift format --in-place Sources/MyFeature/MyFile.swift
```

### 複数ファイルのフォーマット

```bash
swift format --in-place --recursive <directory-path>
```

例：
```bash
swift format --in-place --recursive Sources/
```

### パースできないファイルを無視してフォーマット

```bash
swift format --in-place --recursive --ignore-unparsable-files <directory-path>
```

例：
```bash
swift format --in-place --recursive --ignore-unparsable-files MyLibrary/Sources/
```

## Configuration

### .swift-formatファイルの確認

フォーマットを実行する前に、プロジェクトルートに`.swift-format`ファイルが存在するか確認します：

```bash
ls -la .swift-format
```

### デフォルト設定の使用

プロジェクトに`.swift-format`ファイルが存在しない場合、このスキルに含まれるデフォルト設定を使用できます：

1. デフォルト設定ファイルをプロジェクトルートにコピー：
   ```bash
   cp <skill-path>/assets/.swift-format .
   ```

2. 必要に応じて設定をカスタマイズ

デフォルト設定の主な内容：
- 行の最大長：100文字
- インデント：スペース4個
- タブ幅：4
- ファイルスコープ宣言：`private`をデフォルトに
- コレクション末尾のカンマ：有効

### 設定の検証

フォーマットを実行せずに、変更が必要なファイルを確認：

```bash
swift format --mode diff <file-path>
```

または：

```bash
swift format --mode diff --recursive <directory-path>
```

## Common Workflows

### Workflow 1: 新しく書いたコードをフォーマット

1. 編集したファイルのパスを確認
2. `swift format --in-place <file-path>`を実行
3. フォーマット結果を確認

### Workflow 2: プロジェクト全体をフォーマット

1. プロジェクトルートに移動
2. `.swift-format`ファイルの存在を確認
3. `swift format --in-place --recursive <directory-path>`を実行
4. パースエラーが発生した場合は`--ignore-unparsable-files`オプションを追加

### Workflow 3: コミット前のフォーマット確認

1. 変更されたファイルを特定（`git diff --name-only`）
2. `swift format --mode diff <file-path>`で差分を確認
3. 問題なければ`swift format --in-place <file-path>`でフォーマット実行
4. フォーマット後にコミット

## Common Options

- `--in-place`: ファイルを直接書き換える（デフォルトは標準出力）
- `--recursive`: ディレクトリ内のすべてのSwiftファイルを再帰的に処理
- `--ignore-unparsable-files`: パースできないファイルをスキップ
- `--mode diff`: 変更内容を差分形式で表示
- `--mode lint`: フォーマット違反を検出（CI/CDで使用）
- `--configuration <path>`: 設定ファイルのパスを明示的に指定

## Troubleshooting

### パースエラーが発生する場合

- `--ignore-unparsable-files`オプションを追加
- エラーが発生したファイルを個別に確認

### swift formatコマンドが見つからない場合

Swift 5.6以降がインストールされているか確認：

```bash
swift --version
```

必要に応じてSwiftをアップデート。

### 特定のファイルやコードをフォーマットから除外したい場合

ファイル全体を除外するには、ファイルの先頭にコメントを追加：

```swift
// swift-format-ignore-file
```

特定の宣言やステートメントのみ除外するには：

```swift
// swift-format-ignore
func myFunction() {
    // このフォーマットは保持される
}
```

特定のルールのみ無効化：

```swift
// swift-format-ignore: RuleName1, RuleName2
```

**注意**: `.swift-formatignore`ファイルは存在しません。Swift formatはコメントベースのディレクティブを使用します。

## Resources

### assets/

- `.swift-format`: デフォルトの設定ファイル。プロジェクトに設定ファイルが存在しない場合に使用できます。
