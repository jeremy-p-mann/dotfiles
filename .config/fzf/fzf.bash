[[ $SHELL == *'bash' ]] && PREFIX='bash'
[[ $SHELL == *'zsh' ]] && PREFIX='zsh'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$XDG_HOME_CONFIG/fzf/fzf/shell/completion.$PREFIX" 2> /dev/null

# Key bindings
# ------------
source "$XDG_HOME_CONFIG/fzf/fzf/shell/key-bindings.$PREFIX"
