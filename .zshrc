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
