#!/usr/bin/env fish

# Select a directory using zoxide query or fzf with zoxide-ranked results
function select_directory -a pattern
    if test -n "$pattern"
        zoxide query "$pattern" | sd "$XDG_DEVELOPER_DIR/" ""
    else
        fd . "$XDG_DEVELOPER_DIR" --exact-depth 2 --type d |
            while read --local p
                set p (string trim --right --chars=/ -- "$p")
                set score (zoxide query --list --score "$p")
                test -n "$score" && echo "$score" || echo -e "   0.0 $p"
            end |
            sd "$XDG_DEVELOPER_DIR/" "" |
            sort -rnk1 |
            awk '{print $2}' |
            fzf --tmux center --no-sort
    end
end

# Create or switch to a tmux session for the selected directory
function create_or_switch_session -a selected
    zoxide add "$XDG_DEVELOPER_DIR/$selected"
    set session (string replace --all . - "$selected")

    tmux has-session -t="$session" 2>/dev/null; or begin
        tmux list-sessions &>/dev/null; or echo "Starting tmux..."
        tmux new-session -ds "$session" -c "$XDG_DEVELOPER_DIR/$selected"
    end

    if test -z "$TMUX"
        tmux attach-session -t "$session"
    else
        tmux switch-client -t "$session"
    end
end

# Main function
function main
    set selected (select_directory $argv[1])
    test -z "$selected" && exit 0
    create_or_switch_session "$selected"
end

main $argv
