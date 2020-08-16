# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'

NEWLINE=$'\n' 

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{10}%~${NEWLINE}> %f' 
RPROMPT='%F{248}${vcs_info_msg_0_}%f'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.aliases ] && source ~/.aliases

bindkey -v
