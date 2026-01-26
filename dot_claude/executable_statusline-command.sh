#!/bin/bash

input=$(cat)

model_name=$(echo "$input" | grep -o '"display_name":"[^"]*"' | head -1 | sed 's/"display_name":"//;s/"//')
current_dir=$(echo "$input" | grep -o '"current_dir":"[^"]*"' | head -1 | sed 's/"current_dir":"//;s/"//')
cost=$(echo "$input" | grep -o '"total_cost_usd":[0-9.]*' | head -1 | sed 's/"total_cost_usd"://')
ctx_percent=$(echo "$input" | grep -o '"used_percentage":[0-9.]*' | head -1 | sed 's/"used_percentage"://')

model_name=${model_name:-"Claude"}
current_dir=${current_dir:-$(pwd)}
cost=${cost:-0}
ctx_percent=${ctx_percent:-0}

short_dir=$(basename "$current_dir")
cost_display=$(printf "%.4f" "$cost" 2>/dev/null || echo "0.0000")
ctx_int=$(printf "%.0f" "$ctx_percent" 2>/dev/null || echo "0")

# Git ブランチ情報
if [ -d "$current_dir" ]; then
  git_branch=$(cd "$current_dir" && git rev-parse --abbrev-ref HEAD 2>/dev/null)
else
  git_branch=""
fi

# プログレスバー生成
bar_width=8
filled=$((ctx_int * bar_width / 100))
empty=$((bar_width - filled))
bar=""
for ((i=0; i<filled; i++)); do bar+="█"; done
for ((i=0; i<empty; i++)); do bar+="░"; done

# ANSI カラーコード
reset="\033[0m"

# Powerline セグメントカラー
# モデル: 紫系
model_bg="\033[48;5;93m"
model_fg="\033[38;5;255m"
model_arrow_fg="\033[38;5;93m"

# ディレクトリ: 青系
dir_bg="\033[48;5;24m"
dir_fg="\033[38;5;255m"
dir_arrow_fg="\033[38;5;24m"

# Git: 緑系
git_bg="\033[48;5;22m"
git_fg="\033[38;5;255m"
git_arrow_fg="\033[38;5;22m"

# コンテキスト: 使用率に応じて色変更
if [ "$ctx_int" -ge 80 ]; then
  ctx_bg="\033[48;5;124m"  # 赤
  ctx_arrow_fg="\033[38;5;124m"
elif [ "$ctx_int" -ge 50 ]; then
  ctx_bg="\033[48;5;172m"  # オレンジ
  ctx_arrow_fg="\033[38;5;172m"
else
  ctx_bg="\033[48;5;240m"  # グレー
  ctx_arrow_fg="\033[38;5;240m"
fi
ctx_fg="\033[38;5;255m"

# コスト: シアン系
cost_bg="\033[48;5;30m"
cost_fg="\033[38;5;255m"
cost_arrow_fg="\033[38;5;30m"

# Powerline 矢印
arrow=""

# 出力構築
output=""

# モデル セグメント
output+="${model_bg}${model_fg} ◆ ${model_name} ${reset}"
output+="${dir_bg}${model_arrow_fg}${arrow}${reset}"

# ディレクトリ セグメント
output+="${dir_bg}${dir_fg}  ${short_dir} ${reset}"

# Git セグメント（ブランチがある場合のみ）
if [ -n "$git_branch" ]; then
  output+="${git_bg}${dir_arrow_fg}${arrow}${reset}"
  output+="${git_bg}${git_fg}  ${git_branch} ${reset}"
  output+="${ctx_bg}${git_arrow_fg}${arrow}${reset}"
else
  output+="${ctx_bg}${dir_arrow_fg}${arrow}${reset}"
fi

# コンテキスト セグメント（プログレスバー付き）
output+="${ctx_bg}${ctx_fg}  ${bar} ${ctx_int}% ${reset}"
output+="${cost_bg}${ctx_arrow_fg}${arrow}${reset}"

# コスト セグメント
output+="${cost_bg}${cost_fg}  \$${cost_display} ${reset}"
output+="${cost_arrow_fg}${arrow}${reset}"

printf "%b" "$output"
