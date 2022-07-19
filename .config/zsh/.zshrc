source  $XDG_CONFIG_HOME/fzf/fzf.bash
source  $XDG_CONFIG_HOME/zsh/useful_functions.zsh

source $ZDOTDIR/plugin/fzf-tab/fzf-tab.plugin.zsh
source $ZDOTDIR/plugin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugin/zsh-autosuggestions/zsh-autosuggestions.zsh


for file in $(ls $XDG_CONFIG_HOME/aliases/)
do
    source $XDG_CONFIG_HOME/aliases/$file
done

# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

HISTFILESIZE=1000
HISTSIZE=1000
HISTFILE=~/.config/zsh/zsh_history
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

NEWLINE=$'\n' 

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{#FCB68A}%~${NEWLINE}> %f' 
RPROMPT='%F{248}${vcs_info_msg_0_}%f'

autoload -Uz compinit && compinit

bindkey -v

# #------
# Widgets
# #------

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

[ -n $(zle -la | grep ^fzf-tab-complete$ ) ] && bindkey "^n" fzf-tab-complete || bindkey "^n" complete-word
bindkey "^e" autosuggest-execute
bindkey "^p" fzf-cd-widget
bindkey '^t' fzf-file-widget

export PATH="$HOME/.poetry/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
