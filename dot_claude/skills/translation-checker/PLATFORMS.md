# Platform-Specific Translation Guide

プラットフォーム別の翻訳ファイル形式と特有の注意点

## Contents

- [iOS](#ios)
- [Android](#android)
- [Web (React/Vue)](#web-reactvue)
- [Rails/Ruby](#railsruby)
- [Java/Spring](#javaspring)
- [Gettext](#gettext)
- [Flutter](#flutter)
- [Unity](#unity)

---

## iOS

### ファイル形式

#### .xcstrings (Xcode 15+)
```json
{
  "sourceLanguage": "en",
  "strings": {
    "welcome_message": {
      "localizations": {
        "en": {
          "stringUnit": {
            "state": "translated",
            "value": "Welcome"
          }
        },
        "ja": {
          "stringUnit": {
            "state": "translated",
            "value": "ようこそ"
          }
        }
      }
    }
  },
  "version": "1.0"
}
```

#### .strings (従来形式)
```
/* ボタンラベル */
"Cancel" = "キャンセル";
"Done" = "完了";

/* メッセージ */
"Welcome" = "ようこそ";
```

#### .stringsdict (複数形)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
    <key>%lld Selected</key>
    <dict>
        <key>NSStringLocalizedFormatKey</key>
        <string>%#@count@</string>
        <key>count</key>
        <dict>
            <key>NSStringFormatSpecTypeKey</key>
            <string>NSStringPluralRuleType</string>
            <key>NSStringFormatValueTypeKey</key>
            <string>lld</string>
            <key>one</key>
            <string>%lld個選択</string>
            <key>other</key>
            <string>%lld個選択</string>
        </dict>
    </dict>
</dict>
</plist>
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
YourProject/                              # 例
├── Resources/
│   ├── en.lproj/
│   │   ├── InfoPlist.xcstrings
│   │   └── Localizable.xcstrings
│   ├── ja.lproj/
│   │   ├── InfoPlist.xcstrings
│   │   └── Localizable.xcstrings
│   └── Base.lproj/
│       └── Localizable.xcstrings
または
├── App/
│   └── YourApp/
│       ├── InfoPlist.xcstrings           # Info.plist用の文言
│       └── Localizable.xcstrings         # アプリ全般の文言
└── Features/
    └── FeatureName/
        └── Localizable.xcstrings         # 機能別の文言
```

### プレースホルダー形式

| 型 | 形式 | 例 |
|---|------|-----|
| 文字列 | `%@` | `"Welcome %@"` |
| 整数 | `%lld`, `%d` | `"%lld items"` |
| 浮動小数点 | `%.0f`, `%.2f` | `"%.0f seconds"` |
| 位置指定 | `%1$@`, `%2$lld` | `"%1$@ has %2$lld items"` |

### InfoPlist.xcstringsの特別な注意点

#### 主要キー

| キー | 説明 | 翻訳の注意点 |
|------|------|------------|
| `CFBundleDisplayName` | アプリ表示名 | アプリ名は全言語で統一（例：MyApp） |
| `CFBundleName` | バンドル名 | 変更不要（内部識別用） |
| `NSFaceIDUsageDescription` | Face ID使用許可 | 目的を明確に説明 |
| `NSPhotoLibraryUsageDescription` | 写真ライブラリ許可 | 目的を明確に説明 |
| `NSUserTrackingUsageDescription` | トラッキング許可 | 丁寧に説明 |

**例:**
```
NSPhotoLibraryUsageDescription:
英語: "We will use it to display photos in a slideshow."
日本語: "スライドショーに表示するために利用します"
```

### 検索コマンド

```bash
# .xcstringsファイルを検索
find . -name "*.xcstrings"

# .stringsファイルを検索
find . -name "*.strings"

# 特定のキーを検索
grep -r "\"Cancel\"" **/*.xcstrings
```

---

## Android

### ファイル形式

#### strings.xml
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">MyApp</string>
    <string name="cancel">キャンセル</string>
    <string name="welcome_message">ようこそ、%1$sさん</string>
</resources>
```

#### plurals.xml
```xml
<resources>
    <plurals name="items_selected">
        <item quantity="one">%d個選択</item>
        <item quantity="other">%d個選択</item>
    </plurals>
</resources>
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
app/                                      # 例
└── src/
    └── main/
        └── res/
            ├── values/              # デフォルト（英語）
            │   └── strings.xml
            ├── values-ja/           # 日本語
            │   └── strings.xml
            └── values-ko/           # 韓国語
                └── strings.xml
```

### プレースホルダー形式

| 型 | 形式 | 例 |
|---|------|-----|
| 文字列 | `%s` | `"Welcome %s"` |
| 整数 | `%d` | `"%d items"` |
| 位置指定文字列 | `%1$s`, `%2$s` | `"%1$s has %2$s"` |
| 位置指定整数 | `%1$d`, `%2$d` | `"%1$d of %2$d"` |

### 特殊文字のエスケープ

```xml
<!-- アポストロフィ -->
<string name="message">It\'s a beautiful day</string>

<!-- 引用符 -->
<string name="quote">She said \"Hello\"</string>

<!-- 改行 -->
<string name="multiline">Line 1\nLine 2</string>
```

### 検索コマンド

```bash
# strings.xmlファイルを検索
find . -name "strings.xml" -path "*/values*/strings.xml"

# 特定のキーを検索
grep -r ">Cancel<" **/values*/strings.xml
```

---

## Web (React/Vue)

### ファイル形式

#### JSON形式 (i18next, react-intl)
```json
{
  "common": {
    "cancel": "キャンセル",
    "done": "完了",
    "welcome": "ようこそ、{{name}}さん"
  },
  "errors": {
    "network": "ネットワークエラーが発生しました"
  }
}
```

#### ネストされたJSON
```json
{
  "pages": {
    "home": {
      "title": "ホーム",
      "description": "ようこそ"
    },
    "settings": {
      "title": "設定"
    }
  }
}
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
src/                                      # 例
└── locales/         または i18n/
    ├── en/
    │   └── translation.json
    ├── ja/
    │   └── translation.json
    └── ko/
        └── translation.json
```

### プレースホルダー形式

#### i18next
```json
{
  "welcome": "ようこそ、{{name}}さん",
  "items_count": "{{count}}個のアイテム",
  "items_count_plural": "{{count}}個のアイテム"
}
```

#### ICU MessageFormat
```json
{
  "items": "{count, plural, one {1個のアイテム} other {#個のアイテム}}",
  "gender": "{gender, select, male {彼} female {彼女} other {その人}}"
}
```

### 検索コマンド

```bash
# 翻訳JSONファイルを検索
find . -name "*.json" \( -path "*/i18n/*" -o -path "*/locales/*" \)

# 特定のキーを検索
grep -r "\"cancel\"" **/locales/**/*.json
```

---

## Rails/Ruby

### ファイル形式

#### YAML形式
```yaml
ja:
  common:
    cancel: "キャンセル"
    done: "完了"
  messages:
    welcome: "ようこそ、%{name}さん"
  activerecord:
    errors:
      messages:
        blank: "を入力してください"
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
config/                                   # 例
└── locales/
    ├── en.yml
    ├── ja.yml
    └── ko.yml
```

### プレースホルダー形式

```yaml
ja:
  messages:
    greeting: "こんにちは、%{name}さん"
    items_count: "%{count}個のアイテム"
```

### 複数形

```yaml
ja:
  items:
    one: "1個のアイテム"
    other: "%{count}個のアイテム"
```

### 検索コマンド

```bash
# YAMLファイルを検索
find . -name "*.yml" -path "*/locales/*"

# 特定のキーを検索
grep -r "cancel:" **/locales/*.yml
```

---

## Java/Spring

### ファイル形式

#### .properties
```properties
# messages.properties (デフォルト)
common.cancel=Cancel
common.done=Done
messages.welcome=Welcome, {0}

# messages_ja.properties (日本語)
common.cancel=キャンセル
common.done=完了
messages.welcome=ようこそ、{0}さん
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
src/                                      # 例
└── main/
    └── resources/
        ├── messages.properties        # デフォルト
        ├── messages_ja.properties     # 日本語
        └── messages_ko.properties     # 韓国語
```

### プレースホルダー形式

```properties
# 位置指定
message.greeting=こんにちは、{0}さん。{1}個の新着があります。

# 名前付き（Spring 4.3+）
message.greeting=こんにちは、{name}さん
```

### 特殊文字のエスケープ

```properties
# Unicode エスケープ
message.japanese=\u3088\u3046\u3053\u305d

# または native2ascii を使用
# native2ascii messages_ja.properties messages_ja_ascii.properties
```

### 検索コマンド

```bash
# .propertiesファイルを検索
find . -name "*.properties" -path "*/resources/*"

# 特定のキーを検索
grep -r "common.cancel=" **/*.properties
```

---

## Gettext

### ファイル形式

#### .po (Portable Object)
```po
# ja.po
msgid ""
msgstr ""
"Language: ja\n"
"Content-Type: text/plain; charset=UTF-8\n"

msgid "Cancel"
msgstr "キャンセル"

msgid "Welcome, %s"
msgstr "ようこそ、%sさん"

# 複数形
msgid "1 item"
msgid_plural "%d items"
msgstr[0] "%d個のアイテム"
msgstr[1] "%d個のアイテム"
```

#### .pot (Portable Object Template)
```po
# template.pot
msgid "Cancel"
msgstr ""

msgid "Done"
msgstr ""
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
locales/                                  # 例
├── ja/
│   └── LC_MESSAGES/
│       ├── messages.po
│       └── messages.mo
├── ko/
│   └── LC_MESSAGES/
│       ├── messages.po
│       └── messages.mo
└── templates/
    └── messages.pot
```

### プレースホルダー形式

```po
# C言語形式
msgid "Welcome, %s. You have %d items."
msgstr "ようこそ、%sさん。%d個のアイテムがあります。"

# 位置指定
msgid "%1$s has %2$d items"
msgstr "%1$sには%2$d個のアイテムがあります"
```

### 検索コマンド

```bash
# .poファイルを検索
find . -name "*.po"

# 特定のキーを検索
grep -r "msgid \"Cancel\"" **/*.po
```

---

## Flutter

### ファイル形式

#### .arb (Application Resource Bundle)
```json
{
  "@@locale": "ja",
  "cancel": "キャンセル",
  "welcome": "ようこそ、{name}さん",
  "@welcome": {
    "description": "ウェルカムメッセージ",
    "placeholders": {
      "name": {
        "type": "String",
        "example": "太郎"
      }
    }
  },
  "itemsCount": "{count, plural, =0{アイテムなし} =1{1個のアイテム} other{{count}個のアイテム}}",
  "@itemsCount": {
    "description": "アイテム数",
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
lib/                                      # 例
└── l10n/
    ├── app_en.arb       # 英語
    ├── app_ja.arb       # 日本語
    └── app_ko.arb       # 韓国語
```

### プレースホルダー形式

#### シンプルな置換
```json
{
  "greeting": "こんにちは、{name}さん"
}
```

#### ICU MessageFormat
```json
{
  "items": "{count, plural, =0{なし} =1{1個} other{{count}個}}"
}
```

### 検索コマンド

```bash
# .arbファイルを検索
find . -name "*.arb"

# 特定のキーを検索
grep -r "\"cancel\"" **/*.arb
```

---

## Unity

### ファイル形式

#### CSV形式
```csv
Key,English,Japanese,Korean
common.cancel,Cancel,キャンセル,취소
common.done,Done,完了,완료
messages.welcome,Welcome,ようこそ,환영합니다
```

#### JSON形式
```json
{
  "ja": {
    "common": {
      "cancel": "キャンセル",
      "done": "完了"
    }
  }
}
```

### ファイル場所の例

プロジェクトによってディレクトリ構造は異なりますが、典型的な例：

```
Assets/                                   # 例
└── Resources/
    └── Localization/
        ├── translations.csv
        または
        ├── en.json
        ├── ja.json
        └── ko.json
```

### プレースホルダー形式

Unityのローカライゼーションは通常、`string.Format`を使用：

```csharp
// C#コード
string message = string.Format(localizedText, userName);
```

```csv
Key,English,Japanese
messages.welcome,Welcome {0},ようこそ、{0}さん
```

### 検索コマンド

```bash
# CSVファイルを検索
find . -name "*.csv" -path "**/Localization/*"

# JSONファイルを検索
find . -name "*.json" -path "**/Localization/*"
```

---

## プラットフォーム横断的なチェック

### すべてのプラットフォームで共通のチェック項目

1. **一貫性**: 同じキーが常に同じ訳語
2. **プレースホルダー**: 数と順序が正しい
3. **エスケープ**: 特殊文字が適切にエスケープ
4. **文字エンコーディング**: UTF-8で統一
5. **改行**: プラットフォーム固有の改行コード（`\n`等）

### 包括的な検索コマンド

```bash
# すべての翻訳ファイルを検索
find . -type f \( \
  -name "*.xcstrings" -o \
  -name "*.strings" -o \
  -name "strings.xml" -o \
  -name "*i18n*.json" -o \
  -name "*locale*.json" -o \
  -name "*.po" -o \
  -name "*.pot" -o \
  -name "*messages*.properties" -o \
  -name "*.arb" \
\) | grep -v node_modules | grep -v build | grep -v dist
```
