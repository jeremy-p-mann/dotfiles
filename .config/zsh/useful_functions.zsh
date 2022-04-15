# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
#

E() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
et() {
    nvim . -c ":lua require('jer.telescope').find_tests()"
}
e() {
    if [[ -n $1 ]]; then
        nvim $1
    elif [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
        nvim . -c ":lua require('telescope.builtin').git_files()"
    else
        nvim . -c "lua require('telescope.builtin').find_files()"
    fi
}
fdr() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

rl () {
    [[ $SHELL == *'bash' ]] && source ~/.profile
    [[ $SHELL == *'zsh' ]] && source ~/.zprofile 
    [[ $SHELL == *'zsh' ]] && source $ZDOTDIR/.zshrc
}

tn () {
    session_name=${PWD##*/}
    config=${TMUX_CONFIG}
    tmux -f ${config} new-session -s ${session_name}
}

tr () {
    nvim . -c ":lua require('tarot').telescope_tarots()"
}

create_workstation() {
    name=$1
    directory=$2
    tmux -f ${TMUX_CONFIG} new-session -d -s ${name} -c ${directory}
    tmux list-sessions
    tmux new-window -t ${name} -c ${directory}
    tmux send-keys -t ${name}:0 "$EDITOR ." Enter
}

create_or_attach_work_session () {
  name=$1
  directory=$2
  if [[ -n $TMUX ]]
  then
      if (tmux has-session -t ${name})
      then
          tmux -f ${TMUX_CONFIG} switch -t ${name}
      else
          create_workstation $name $directory
          tmux -f ${TMUX_CONFIG} switch -t ${name}:0
      fi
  else
      if (tmux has-session -t ${name})
      then
        tmux -f ${TMUX_CONFIG} attach -t ${name}
      else
        create_workstation $name $directory
        tmux -f ${TMUX_CONFIG} attach -t ${name}:0
      fi
  fi
}

td () {
  create_or_attach_work_session "pde" $DOTFILES
}


tp () {
  IFS=$'\n' files=($(ls $CODEDIR| fzf-tmux --multi --select-1 --exit-0))
  [[ -n "$files" ]] &&  folder="${files[@]}"
  directory=$CODEDIR/$folder
  create_or_attach_work_session $folder $directory
}

cf () {
    project=($(ls $CODEDIR | fzf-tmux))
    cd $CODEDIR/$project
}
