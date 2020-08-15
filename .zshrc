# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'

NEWLINE=$'\n' 

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${NEWLINE}> '
RPROMPT=\$vcs_info_msg_0_

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.aliases ] && source ~/.aliases

bindkey -v
