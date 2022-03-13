# Jeremy's Profile
if [ $(uname) = "Darwin" ]; then
    export BASEDIR=$HOME/Documents
else
    export BASEDIR=$HOME
fi
export DOTFILEDIR=$BASEDIR/dotfiles
export XDG_HOME_CONFIG=$DOTFILEDIR/.config
source $XDG_HOME_CONFIG/env/env.sh

# source bashrc if shell is bash and interactive
[[ $SHELL == *'bash' ]] && [[ $- == *i* ]] && source $XDG_HOME_CONFIG/bash/.bashrc
