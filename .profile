# Jeremy's Profile
export XDG_HOME_CONFIG=$HOME/.config
source $XDG_HOME_CONFIG/env/env.sh

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# source bashrc if shell is bash and interactive
[[ $SHELL == *'bash' ]] && [[ $- == *i* ]] && source $HOME/.bashrc
