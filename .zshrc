eval "$(anyenv init -)"

export CLICOLOR=1
export LSCOLORS="GxFxCxDxBxegedabagaced"

# 補完
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u

eval "$(direnv hook zsh)"

# Big Sur rbenv workaround
# ----------------------------------
#
# eval "$(rbenv init -)"
# 
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
# 
# export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib:$LDFLAGS"
# export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include:$CPPFLAGS"
# 
# export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig:$PKG_CONFIG_PATH"
# ----------------------------------

# export PATH="/usr/local/opt/ruby/bin:$PATH"
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^[' peco-src
