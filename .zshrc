# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# plugin gonfig
# ══════════════════════════════════════════════════════════════════════
# 2. 命令补全
# ══════════════════════════════════════════════════════════════════════
# Zsh 补全系统增强
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh-completions:$FPATH"
    FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi

# 初始化补全系统（必须在设置 FPATH 之后、加载补全脚本之前）
autoload -Uz compinit
# 使用缓存加速，每天只重建一次
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# ══════════════════════════════════════════════════════════════════════
# 5. Zsh 插件
# ══════════════════════════════════════════════════════════════════════
# zsh-autosuggestions - 根据历史命令自动补全建议（灰色提示）
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# zsh-syntax-highlighting - 命令语法高亮
if [ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# bindkey '^I' forward-word

# ══════════════════════════════════════════════════════════════════════
# 6. 提示符主题 (Starship)
# ══════════════════════════════════════════════════════════════════════
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# 7. PATH
#export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="/opt/homebrew/bin:$PATH"

# nvm lazy to make start fast
lazy_load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  nvm $@
}
# mysql
export PATH="/opt/homebrew/opt/mysql@8.4/bin:$PATH"

# Added by coco installer
export PATH="/Users/bytedance/.local/bin:$PATH"


# 8. alias
alias ll='ls -alFG'
