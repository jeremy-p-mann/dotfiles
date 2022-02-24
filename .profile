# Jeremy's Profile
export XDG_HOME_CONFIG=$HOME/.config
source $XDG_HOME_CONFIG/env/env.sh

# source bashrc if shell is bash and interactive
[[ $SHELL == *'bash' ]] && [[ $- == *i* ]] && source $XDG_HOME_CONFIG/bash/.bashrc
