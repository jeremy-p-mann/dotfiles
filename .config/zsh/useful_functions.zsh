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
ed() {
    nvim . -c ":lua require('edc').pick_question_keymap()"
}
es() {
    nvim . -c ":lua require('telescope.builtin').git_status()"
}
ef() {
    nvim . -c ":lua require('telescope.builtin').live_grep()"
}
ep() {
    nvim . -c ":lua require('edc').preview_data()"
}
fdr() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

sgd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}

fbr() {
  local branches branch
  branches=$(git branch) &&
  branch=$(echo "$branches" | fzf-tmux -d 15 +m) &&
  git checkout $(echo "$branch" | sed "s/.* //")
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
    tmux send-keys -t ${name}:0 "e" Enter
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

tw () {
  create_or_attach_work_session "writing" $WRITING
}


ts () {
  create_or_attach_work_session "scratch" $SCRATCH_FILE
}


fp () {
  IFS=$'\n' files=($(ls $CODEDIR| fzf-tmux --multi --select-1 --exit-0))
  [[ -n "$files" ]] &&  folder="${files[@]}"
  directory=$CODEDIR/$folder
  create_or_attach_work_session $folder $directory
}

cf () {
    project=($(ls $CODEDIR | fzf-tmux))
    cd $CODEDIR/$project
}

def () {
    dict $1 | bat
}

grs () {
    git reset --soft HEAD~$1
}

gq () {
    git reset --soft HEAD~$1
    git commit
}
