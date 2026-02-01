add-completion() {
    if [ $# -lt 1 ]; then
        echo "Usage: add-zsh-completion <tool-name> [command]"
        echo "Example: add-zsh-completion podman"
        echo "Example: add-zsh-completion podman 'podman completion zsh'"
        return 1
    fi
    
    local tool="$1"
    local cmd="${2:-$tool completion zsh}"
    local dir="${HOME}/.zsh/completions"
    local file="${dir}/_${tool}.zsh"
    mkdir -p "$dir"
    
    echo "Downloading completion for $tool..."
    if eval "$cmd" > "$file" 2>/dev/null; then
        echo "✓ Saved to: $file"
        
        # Add to fpath if needed
        if [[ ! ":${fpath}:" == *":${dir}:"* ]]; then
            echo "fpath=($dir \$fpath)" >> ~/.zshrc
            echo "✓ Added $dir to fpath in ~/.zshrc"
        fi
        
        # Reinitialize completions
        autoload -Uz compinit && compinit
        echo "✓ Completions reinitialized"
        echo ""
        echo "Restart shell or run: source ~/.zshrc"
    else
        echo "✗ Failed to download completion"
        echo "Try: $tool --help | grep -i completion"
        return 1
    fi
}
add-completion-cmd() {
    if [ $# -lt 1 ]; then
        echo "Usage: add-zsh-completion <tool-name> [command]"
        echo "Example: add-zsh-completion podman"
        echo "Example: add-zsh-completion podman 'podman completion zsh'"
        return 1
    fi
    
    local cmd="$1"
    local tool="${cmd%% *}"
    local dir="${HOME}/.zsh/completions"
    local file="${dir}/_${tool}.zsh"
    mkdir -p "$dir"
    
    echo "Downloading completion for $tool..."
    if eval "$cmd" > "$file" 2>/dev/null; then
        echo "✓ Saved to: $file"
        
        # Add to fpath if needed
        # if [[ ! ":${fpath}:" == *":${dir}:"* ]]; then
        #     echo "fpath=($dir \$fpath)" >> ~/.zshrc
        #     echo "✓ Added $dir to fpath in ~/.zshrc"
        # fi
        
        # Reinitialize completions
        autoload -Uz compinit && compinit
        echo "✓ Completions reinitialized"
        echo ""
        echo "Restart shell or run: source ~/.zshrc"
    else
        echo "✗ Failed to download completion"
        echo "Try: $tool --help | grep -i completion"
        return 1
    fi
}

