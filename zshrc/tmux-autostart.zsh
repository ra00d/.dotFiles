
# ===================== CONFIGURATION =====================
TMUX_AUTO_START=true               # Set to false to disable auto-start
TMUX_START_PATH="$HOME/repositories/personal/"   # Default starting directory
TMUX_SESSION_NAME="personal"           # Default session name
TMUX_ATTACH_EXISTING=true          # Attach to existing session if true, create new if false
# =========================================================

# Function to auto-start tmux
tmux_autostart() {
    # Exit if already in tmux or auto-start is disabled
    [ -n "$TMUX" ] && return
    [ "$TMUX_AUTO_START" != "true" ] && return
    
    # Check if tmux is installed
    if ! command -v tmux &> /dev/null; then
        echo "tmux is not installed. Skipping auto-start."
        return 1
    fi
    
    # Check if we're in an SSH session (optional: disable for SSH)
    # [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && return
    
    # Check if we're in a graphical terminal (optional)
    # [ "$TERM" = "linux" ] && return
    
    # Navigate to starting path if it exists
    if [ -d "$TMUX_START_PATH" ]; then
        cd "$TMUX_START_PATH" || echo "Warning: Could not cd to $TMUX_START_PATH"
    else
        echo "Warning: TMUX_START_PATH '$TMUX_START_PATH' does not exist. Using current directory."
    fi
    
    # Check for existing tmux sessions
    if tmux has-session -t "$TMUX_SESSION_NAME" 2>/dev/null; then
        if [ "$TMUX_ATTACH_EXISTING" = "true" ]; then
            # echo "Attaching to existing tmux session: $TMUX_SESSION_NAME"
            tmux attach-session -t "$TMUX_SESSION_NAME"
        else
            # Create a new session with a unique name
            local timestamp=$(date +%s)
            local new_session_name="${TMUX_SESSION_NAME}-${timestamp}"
            # echo "Creating new tmux session: $new_session_name"
            tmux new-session -s "$new_session_name"
        fi
    else
        echo "Creating new tmux session: $TMUX_SESSION_NAME"
        tmux new-session -s "$TMUX_SESSION_NAME"
    fi
}

# Run the auto-start function
tmux_autostart
