#!/usr/bin/env bash
#
# Inspired by https://github.com/ThePrimeagen/tmux-sessionizer/blob/master/tmux-sessionizer

switch_to() {
  if [[ -z $TMUX ]]; then
    tmux attach-session -t $1
  else
    tmux switch-client -t $1
  fi
}

has_session() {
  tmux list-sessions | rg -q "^$1:"
}

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(fd . $XDG_DEVELOPER_DIR --exact-depth 2 --type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

session_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s $session_name -c $selected
  exit 0
fi

if ! has_session $session_name; then
  tmux new-session -ds $session_name -c $selected
fi

switch_to $session_name
