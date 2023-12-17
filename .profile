# Jeremy's Profile
if [ $(uname) = "Darwin" ]; then
    export BASEDIR=$HOME/Documents
else
    export BASEDIR=$HOME
fi
[ -z $SHELL ] && export SHELL='bash'
export DOTFILEDIR=$BASEDIR/dotfiles
export XDG_CONFIG_HOME=$HOME/.config
source $XDG_CONFIG_HOME/env/env.sh

# source bashrc if shell is bash and interactive
[[ $SHELL == *'bash' ]] && [[ $- == *i* ]] && source $XDG_CONFIG_HOME/bash/.bashrc

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
