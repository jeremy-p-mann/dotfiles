if [ $(uname) = "Darwin" ]; then
    export BASEDIR=$HOME/Documents
else
    export BASEDIR=$HOME
fi
export DOTFILEDIR=$BASEDIR/dotfiles
export XDG_HOME_CONFIG=$DOTFILEDIR/.config
export CLICOLOR=1
export EDITOR=nvim
export IPYTHONDIR=$XDG_HOME_CONFIG/ipython
export TASKRC=$XDG_HOME_CONFIG/task/taskrc
export LESSHISTFILE="-"
export PTPYTHON_CONFIG_HOME="$XDG_HOME_CONFIG/ptpython"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export ZDOTDIR=$XDG_HOME_CONFIG/zsh
export ANSIBLE_CONFIG=$XDG_HOME_CONFIG/ansible/ansible.cfg
export TMUX_CONFIG=$XDG_HOME_CONFIG/tmux/.tmux.conf

