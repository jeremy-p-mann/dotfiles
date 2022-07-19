# Jeremy's Profile
if [ $(uname) = "Darwin" ]; then
    export BASEDIR=$HOME/Documents
else
    export BASEDIR=$HOME
fi
export DOTFILEDIR=$BASEDIR/dotfiles
export XDG_CONFIG_HOME=$DOTFILEDIR/.config
source $XDG_CONFIG_HOME/env/env.sh

# source bashrc if shell is bash and interactive
[[ $SHELL == *'bash' ]] && [[ $- == *i* ]] && source $XDG_HOME_CONFIG/bash/.bashrc

export PATH="$HOME/.poetry/bin:$PATH"
