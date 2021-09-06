#!/bin/sh

tmux has-session -t dotfiles

if [ $? = 1 ]
then 
    tmux -f ~/.config/tmux/.tmux.conf new-session -s dotfiles -d -n vimdots 
    tmux new-window -t dotfiles -d -n config
    tmux new-window -t dotfiles -d -n root
    tmux new-window -t dotfiles -d -n exdots
    tmux new-window -t dotfiles -d -n practice

    tmux -u -f ~/.config/tmux/.tmux.conf attach -t dotfiles
else
    tmux -u -f ~/.config/tmux/.tmux.conf attach -t dotfiles
fi
