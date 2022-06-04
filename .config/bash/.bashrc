
source $XDG_CONFIG_HOME/fzf/fzf.bash

for file in $(ls $XDG_CONFIG_HOME/aliases/)
do
    source $XDG_CONFIG_HOME/aliases/$file
done


shopt -s histappend;

set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# ------
# PROMPT
# ------

prompt_git() {
	local branchName='';

	git rev-parse --is-inside-work-tree &>/dev/null || return;

	branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
		git describe --all --exact-match HEAD 2> /dev/null || \
		git rev-parse --short HEAD 2> /dev/null || \
		echo '(unknown)')";
	repoUrl="$(git config --get remote.origin.url)";
	echo -e "${1}${branchName}${2}${s}";
}

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 10);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[0;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	userStyle="${red}";
else
	userStyle="${orange}";
fi;

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	hostStyle="${bold}${red}";
else
	hostStyle="${yellow}";
fi;

# Set the terminal title and prompt.
PS1="\[\033]0;\W\007\]"; # working directory base name
PS1+="\[${green}\]\w"; # working directory full path
PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
PS1+="\n";
PS1+="\[${green}\]\$ \[${reset}\]"; # `$` (and reset color)
export PS1;

PS2="\[${yellow}\]→ \[${reset}\]";
export PS2;
