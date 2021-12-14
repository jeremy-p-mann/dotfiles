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
