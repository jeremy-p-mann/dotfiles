[[ $SHELL == *'bash' ]] && PREFIX='bash'
[[ $SHELL == *'zsh' ]] && PREFIX='zsh'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$XDG_CONFIG_HOME/fzf/fzf/shell/completion.$PREFIX" 2> /dev/null

# Key bindings
# ------------
source "$XDG_CONFIG_HOME/fzf/fzf/shell/key-bindings.$PREFIX"
