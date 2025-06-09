#!/usr/bin/env fish

set session_name gh-dash

# Toggle the scratch terminal as a popup on or off
function toggle_gh_dash
    if test "$(tmux display-message -p -F '#{session_name}')" = "$session_name"
        tmux detach-client
    else
        tmux popup -d "#{pane_current_path}" -h 90% -w 90% -E "tmux attach-session -t $session_name || tmux new-session -s $session_name gh-dash"
    end
end

# Main function 
function main
    # if we're currently not in tmux
    if test -z $TMUX
        tmux new-session -A -s "$session_name" -c "$HOME" gh-dash
    else
        toggle_gh_dash
    end
end

main
