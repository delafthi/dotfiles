#!/usr/bin/env fish

if test -z $TMUX
    echo "csd: not in a tmux session" >&2
    exit 1
end

cd $argv[1] && tmux set-option default-path $PWD
