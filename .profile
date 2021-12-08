# Jeremy's Profile
export XDG_HOME_CONFIG=$HOME/.config
source $XDG_HOME_CONFIG/env/env.sh
source $XDG_HOME_CONFIG/bash/.bashrc

# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

