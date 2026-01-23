# Function to open file:line:col
vif() {
    local file=${1%:*}
    local rest=${1#*:}
    local line=${rest%:*}
    local col=${rest#*:}
    
    if [[ $col == $line ]]; then
        # Only line number provided
        nvim "+$line" "$file"
    else
        # Both line and column provided
        nvim "+call cursor($line, $col)" "$file"
    fi
}

# Alias for quick access
alias vimto='vif'

# Using FZF
fzf-vim-open() {
    local file
    file=$(grep -n "." | fzf --delimiter ":" --preview "bat --color=always --style=numbers --line-range=:500 {1}" | awk -F: '{print "+"$2" "$1}')
    [[ -n "$file" ]] && nvim $file
}
zle -N fzf-vim-open
bindkey '^F' fzf-vim-open
