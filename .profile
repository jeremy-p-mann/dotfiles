# Jeremy's Profile
BASHRC_CONFIG_DIR=~/.config/bash
export XDG_HOME_CONFIG=$HOME/.config
[ -f $XDG_HOME_CONFIG/env/env.sh ] && source $XDG_HOME_CONFIG/env/env.sh


if [ -n "$BASH" ] && [ -r $BASHRC_CONFIG_DIR/.bashrc ] && [ -r ~/.config/fzf/fzf.bash ]; then
    . $BASHRC_CONFIG_DIR/.bashrc
    . ~/.config/fzf/fzf.bash
fi



for file in $(ls $XDG_HOME_CONFIG/aliases/)
do
    source $XDG_HOME_CONFIG/aliases/$file
done
