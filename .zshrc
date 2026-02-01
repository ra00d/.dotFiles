# ==================================================
# Early environment & completion paths (must be first)
# ==================================================

# Add deno completions to search path
if [[ ":$FPATH:" != *":/mnt/main/ra0_0d/.zsh/completions:"* ]]; then
  export FPATH="/mnt/main/ra0_0d/.zsh/completions:$FPATH"
fi

# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"

autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
CASE_SENSITIVE="true"


if [[ -f ~/.local_env_vars.zsh ]]; then
  source ~/.local_env_vars.zsh
fi

for file in ~/.dotFiles/zshrc/*.zsh(.N); do
  source "$file"
done


# ==================================================
# Zsh core configuration
# ==================================================

# Path to your oh-my-zsh installation.
export ZSH="/usr/share/zsh"

setopt prompt_subst


zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{cyan}— %d —%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# HYPHEN_INSENSITIVE="true"
# DISABLE_MAGIC_FUNCTIONS="true"
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

DISABLE_UNTRACKED_FILES_DIRTY="true"

# HIST_STAMPS="mm/dd/yyyy"

# ZSH_CUSTOM=/path/to/new-custom-folder

# ==================================================
# Plugins
# ==================================================


if [[ -f  $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
if [[ -f  $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ==================================================
# Key bindings & ZLE
# ==================================================

bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^a' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=()
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

bindkey ' ' magic-space

# VI Mode!!!
bindkey jj vi-cmd-mode

# ==================================================
# History
# ==================================================

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# ==================================================
# Locale & editor
# ==================================================

export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ==================================================
# Terminal, tmux & pager
# ==================================================

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# TMUX CONFIG
# export TMUX_CONF=~/.dotFiles/tmux/tmux.conf

export TERM="xterm-256color"
# alias tmux='tmux -2'
alias ts='tmux -2 new-session -s ${PWD##*/}'
alias ta='tmux -2 attach'

export MANPAGER='nvim +Man!'

# ==================================================
# FZF
# ==================================================

source <(fzf --zsh)

# export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC 
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 
  --color=selected-bg:#45475A 
  --color=border:#6C7086,label:#CDD6F4
  --border="rounded" --border-label="" --preview-window="border-rounded" --prompt="=> "
  --marker="> " --pointer="◆" --separator="─" --scrollbar="│"
  --info="right"'

# ==================================================
# Git helpers
# ==================================================

gch() {
  local branch
  branch=$(git branch --all | grep -v HEAD | sed 's/remotes\/origin\///' | sort -u | \
    fzf --prompt="Checkout or create branch: " --print-query | tail -1 | awk '{$1=$1};1')

  if [[ -n $branch ]]; then
    if git show-ref --verify --quiet "refs/heads/$branch"; then
      git checkout "$branch"
    else
      echo "Branch '$branch' does not exist. Creating it..."
      git checkout -b "$branch"
    fi
  else
    echo "No branch selected."
  fi
}

# ==================================================
# Neovim & man
# ==================================================

export GITIGNORE_TEMPLATES_DIR=~/.dotFiles/gitignore/

vv() {
  local config=$(fd --max-depth 1 --glob '*nvim' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $config ]] && echo "No config selected" && return
  NVIM_APPNAME=$(basename $config) nvim
}

export NVIM_APPNAME="lazy-nvim"

alias v="nvim "
alias lv="~/bin/nvim/bin/nvim ."
alias vim="nvim "
alias nv="nvim "
alias svim='sudo -E XDG_CONFIG_HOME=$HOME/.config nvim'

# ==================================================
# POSTGRESQL
# ==================================================
if  postgres -V &>/dev/null  ; then
  # echo "PostgreSQL detected"
export PGROOT=$HOME/.local/share/postgresql/$(postgres -V | awk '{print $3}')
export PGDATA=$HOME/.local/share/postgresql/$(postgres -V | awk '{print $3}')/data
fi


# ==================================================
# Aliases
# ==================================================

# Suffix aliases
alias -s json=jless
alias -s md=bat
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s html=open  # macOS: open in default browser

# Arch Linux
alias i="sudo pacman --needed -Sy"

# ls
alias ls="eza -l --icons --git"
alias lst="eza --tree --level=2 --long --icons --no-permissions"
alias ols="/usr/bin/ls"
alias l=ls
alias lt=lst
alias zls="clear"

# navigation
alias j=z
alias zs="source ~/.zshrc"
alias zc="nvim ~/.zshrc"
alias ..="cd .."
alias ...="cd ../.."

# safety
alias cp="cp -vi"
alias mv="mv -vi"
alias kill="kill -9"

# git
alias g="git"
alias gs="git status"
alias gP="git pull"
alias gu="git pull"
alias gpl='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

# php
alias art="php artisan"

# python
alias py=python3
alias pip=pip3

# node / nest
alias nn="nest new"
alias ng="nest generate"
alias ns="pnpm start:dev"
alias n="nest"
alias nest-set="pnpm add @nestjs/config @nestjs/typeorm typeorm mysql2 class-validator class-transformer @nestjs/serve-static @nestjs/passport passport passport-local express-session cookie-parser helmet bcrypt connect-typeorm typeorm-extension"
alias nest-set-dev="pnpm add -D @types/cookie-parser @types/express-session @types/passport-local @types/multer @types/bcrypt"

# kubernetes
alias kctl=kubectl
alias k=kubectl
alias mk=kubectl


# ==================================================
# Toolchains & PATH
# ==================================================

export XDG_CONFIG_HOME=$HOME/.config

export PATH=~/.dotnet/tools:$PATH
export PATH=~/.config/composer/vendor/bin:$PATH
export PATH=/usr/lib/docker/cli-plugins:$PATH

export JAVA_HOME="/usr/lib/jvm/default"
export ANDROID_HOME=$HOME/.android
export ANDROID_NDK_HOME=$ANDROID_HOME/ndk/27.1.12297006
export NDK_HOME=$ANDROID_NDK_HOME
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:$(go env GOPATH)/bin

export PNPM_HOME="/home/ra0_0d/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="/mnt/main/ra0_0d/AppImages:$PATH"

export NEXT_TELEMETRY_DISABLED=1

# ==================================================
# Node.js / NVM
# ==================================================

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    nvm use --silent || nvm install
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ]; then
    nvm use default --silent
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# ==================================================
# Enhancements & misc
# ==================================================

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.dotFiles/starship.toml

. "/mnt/main/ra0_0d/.deno/env"



# alias php='php-legacy'

# export HTTP_PROXY="http://192.168.0.104:44355/"
# export HTTPS_PROXY="http://192.168.0.104:44355/"
# export http_proxy="http://192.168.0.104:44355/"
# export https_proxy="http://192.168.0.104:44355/"
# export socks_proxy="socks5://192.168.0.104:10808/"


fpath=(/mnt/main/ra0_0d/.zsh/completions $fpath)
fpath=(/mnt/main/ra0_0d/.zsh/completions $fpath)
fpath=(/mnt/main/ra0_0d/.zsh/completions $fpath)
