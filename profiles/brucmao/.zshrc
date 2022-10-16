if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod g-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# ZSH option

## history setting
setopt HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_SAVE_NO_DUPS INC_APPEND_HISTORY

## pushd and other
setopt PUSHD_IGNORE_DUPS AUTO_PUSHD AUTO_LIST INTERACTIVE_COMMENTS AUTO_CD

# completion settings - pretty print - ignore case
 zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
 zstyle ':completion:*:matches' group 'yes'
 zstyle ':completion:*:options' description 'yes'
 zstyle ':completion:*:options' auto-description '%d'
 zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
 zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
 zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
 zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
 zstyle ':completion:*:default' list-prompt '%S%M matches%s'
 zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
 zstyle ':completion:*' group-name ''
 zstyle ':completion:*' verbose yes
 zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
 zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
 zstyle ':completion:*' use-cache true
 zstyle ':completion:*' rehash true

# exports

## faster startup, but less safer
export ZSH_DISABLE_COMPFIX="true"

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

# proxy
export hostip=$(cat /etc/resolv.conf |grep "nameserver" |cut -f 2 -d " ")
alias setss='export all_proxy="https://${hostip}:7890";'
alias unsetss='unset all_proxy'

export PATH=/root/.cargo/bin:$PATH
export LANG=en_US.UTF-8


zi wait lucid light-mode depth"1" for \
  atinit"ZI[COMPINIT_OPTS]=-C;" \
    z-shell/F-Sy-H \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' atload" \
    PURE_PROMPT_SYMBOL='λ';" \
    sindresorhus/pure \
  as'completion' atload'zicompinit; zicdreplay' \
    zsh-users/zsh-completions \
  multisrc="{directories,functions}.zsh" pick"/dev/null" \
    Colerar/omz-extracted \
  as"completion" blockf \
  https://raw.githubusercontent.com/Colerar/Tracks/cli/completions/_tracks \
  https://gist.githubusercontent.com/Colerar/2f23c76583ac7866a50cda5bb04ff3a4/raw/sha-alias.plugin.zsh \
  Colerar/zsh-aliases-exa \
  jeffreytse/zsh-vi-mode \
  OMZL::git.zsh \
  OMZP::git \
  OMZP::autojump \



zi wait lucid light-mode from"gh-r" for \
    as"program" bpick"*amd64*.deb" pick"usr/bin/atuin" \
    atclone"echo clone"                   \
    atpull"echo update"                  \
    atinit"export ATUIN_NOBIND='true'"   \
    atload'eval "$(atuin init zsh)"'  \
    atload"bindkey -M vicmd -r  '^r' && bindkey '^r' _atuin_search_widget" \
    ellie/atuin

zi light z-shell/z-a-bin-gem-node

zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide

zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide

zi from"gh-r" as"null" for \
  sbin"fzf" junegunn/fzf \
  sbin"**/fd" @sharkdp/fd \
  sbin"**/bat" @sharkdp/bat \


# Alias

alias rm='move1(){ /bin/mv -f $@ ~/.trash/; };move1 $@'

alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

emptytrash() {
  sudo /bin/rm -rf ~/.trash/*
}

alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'
alias -s zshrc=vi
alias -s zsh=zsh
alias gcid="git rev-parse --short HEAD | pbcopy"

alias tracksub="tracks dig -so -ze -zt China"

% function xbin() {
  command="$1"
  args="${*:2}"
  if [ -t 0 ]; then
    curl -sS -X POST "https://xbin.io/${command}" -H "X-Args: ${args}"
  else
    curl -sS --data-binary @- "https://xbin.io/${command}" -H "X-Args: ${args}"
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/root/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
