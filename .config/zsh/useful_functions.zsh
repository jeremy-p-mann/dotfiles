# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
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


tp () {
  IFS=$'\n' files=($(ls $CODEDIR| fzf-tmux --multi --select-1 --exit-0))
  [[ -n "$files" ]] &&  folder="${files[@]}"
  directory=$CODEDIR/$folder
  if [[ -n $TMUX ]]
  then
      if (tmux has-session -t ${folder})
      then
          tmux -f ${TMUX_CONFIG} switch -t ${folder}
      else
          tmux -f ${TMUX_CONFIG} new -s ${folder} -d -c ${directory}
          tmux -f ${TMUX_CONFIG} switch -t ${folder}
      fi
  else
      if (tmux has-session -t ${folder})
      then
        tmux -f ${TMUX_CONFIG} attach -t ${folder}   
      else
        tmux -f ${TMUX_CONFIG} new -s ${folder} -c ${directory}
      fi
  fi
}

