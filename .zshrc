# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting vi-mode)

bindkey -e

bindkey '^I'      autosuggest-accept
bindkey '^e'      autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward



ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# SYSTEM PACKAGE MANAGER [BREW]
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export  HOMEBREW_NO_AUTO_UPDATE=1



# PROGRAMING LANGUAGE RELATED CONFIGURATION
# THIS IS FOR PROGRAMING LANGUAGES PATHS, PACKAGES, FILES, 
# FOLDERS, AND BIN FILES
# 
#################### RUBY ####################################
#                                                            #
## gems path evry gem should be installed using the --user-install
# alias for that 
alias gem_install='gem install --user-install'
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi


#################### GOLANG ####################################
#                                                            #
#
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:$(go env GOROOT)/misc/wasm
# export GOROOT="$HOME/go"
############### TOOLS AND TERMINAL  RELATED CONFIGURATION ####
#################### TMUX ####################################
#                                                            #
# TMUX CONFIG
export TMUX_CONF=~/.dotFiles/tmux/tmux.conf
export TERM="xterm-256color"
# alias tmux='tmux -2'
alias ts='tmux -2 new-session -s ${PWD##*/}'
set -g default-terminal "xterm"
alias ta='tmux -2 attach'
# export TMUX_CONF_LOCAL=~/.dotFiles/tmux
#
#################### AUTOJUMP ####################################
#                                                            #
# AUTOJUMP CONFIG
 # [ -f /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh ] && . /home/linuxbrew/.linuxbrew/etc/profile.d/autojump.sh


#################### FZF ####################################
source <(fzf --zsh)



#################### DATABASE RELATED CONFIGURATION ##################
# POSTGRESQL CONFIG
export PATH="/home/linuxbrew/.linuxbrew/opt/postgresql@16/bin:$PATH"
export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/postgresql@16/lib"
export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/postgresql@16/include"
####################NVIM CONFIGURATION##################################
vv() {
  # Assumes all configs exist in directories named ~/.config/*-nvim
  local config=$(fd --max-depth 1 --glob '*-nvim' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return
  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim
}
# vim aliases
export NVIM_APPNAME="chad-nvim"
alias v="nvim ."
alias vim="nvim ."
alias nv="nvim ."
alias obsidian="~/bin/obsidian"
#################### ALIASES ####################################
#                                                               #
# aliases 
alias ls="eza -l --icons --git -a"
alias lst="eza --tree --level=2 --long --icons --git"
# alias cd=z
# alias j=z

alias zs="source ~/.zshrc"
alias zc="nvim ~/.zshrc"
# copy and move with confirmation
alias cp="cp -vi"
alias mv="mv -vi"

# kill process for good 
alias kill="kill -9"

# change directory commands
alias ..="cd .."
alias ...="cd ../.."

# mysql
alias msq="mysql -u root"

#git
alias g="git"
alias gs="git status"
alias gP="git pull"

# @nestjs/cli
alias nn="nest new"
alias ng="nest generate"
alias n="nest"
# INSTALL ALL DEPENDENCIES
alias nest-set="pnpm add @nestjs/config @nestjs/typeorm typeorm mysql2 class-validator class-transformer @nestjs/serve-static @nestjs/passport passport passport-local express-session cookie-parser helmet"
# INSTALL ALL DEV DEPENDENCIES
alias nest-set-dev="pnpm add -D @types/cookie-parser @types/express-session @types/passport-local @types/multer"

# php artisan
alias art="php artisan"

# python
alias py=python3
alias pip=pip3
# pnpm
export PNPM_HOME="/home/ra0_0d/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
alias p=pnpm
alias pdev="pnpm dev"
# pnpm end

# Load Angular CLI autocompletion.
# source <(ng completion script)

# bun completions
[ -s "/home/ra0_0d/.bun/_bun" ] && source "/home/ra0_0d/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh



#################### PATH ####################################
#

export PATH="/mnt/c/Windows:$PATH"
export PATH="/mnt/c/Program Files/Docker/Docker/resources/bin:$PATH"
export PATH="/mnt/c/Users/WD/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
export PATH="/snap/bin:$PATH"

# Android
export PATH=$HOME/android/cmdline-tools/12.0/bin:$PATH
export PATH=$HOME/android/emulator:$PATH
export PATH=$HOME/android/platform-tools:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    chpwd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" && __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query --interactive -- "$@")" && __zoxide_cd "${result}"
}
eval "$(zoxide init zsh)"
