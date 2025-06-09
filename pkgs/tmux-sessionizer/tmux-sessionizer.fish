#!/usr/bin/env fish
#
# Inspired by https://github.com/ThePrimeagen/tmux-sessionizer/blob/master/tmux-sessionizer and https://github.com/caarlos0/dotfiles/blob/main/pkgs/bins/bin/tmux-sessionizer

# Query zoxide with the provided pattern and select the highest ranking match
function select_with_zoxide -a pattern
    zoxide query "$argv[1]" | sd "$XDG_DEVELOPER_DIR/" ""
end

# Query zoxide for a directory's score
# If zoxide has no entry for the directory, returns a score of zero.
# Otherwise, returns the zoxide score and path.
# Trims trailing slashes from <dir> before querying.
function zoxide_query_with_zero_score -a dir
    # trim the trailing slash from the path
    set trimmed_dir (string trim -r -c / -- "$dir")
    set score (zoxide query -l -s "$trimmed_dir")
    if test -z "$score"
        echo -e "   0.0 $trimmed_dir"
    else
        echo "$score"
    end
end

# List, rank, and display directories under $XDG_DEVELOPER_DIR for selection
function fzf_dev_dirs
    fd . "$XDG_DEVELOPER_DIR" --exact-depth 2 --type d |
        while read p
            zoxide_query_with_zero_score "$p"
        end |
        sd "$XDG_DEVELOPER_DIR/" "" | # removes the $XDG_DEVELOPER_DIR/ prefix
        sort -rnk1 | # sort by score descending
        awk '{print $2}' | # output only the directory path, not the score
        fzf --tmux center --no-sort
end

# Increase the zoxide score for a directory
function increase_zoxide_rank -a dir
    zoxide add "$XDG_DEVELOPER_DIR/$dir"
end

# Main function
function main
    # if we provide only one argument try to jump to it with zoxide
    if test (count $argv) -eq 1
        set selected "$(select_with_zoxide "$argv[1]")"
    else # else we open the search prompt
        set selected (fzf_dev_dirs)
    end

    # exit if we didn't selet something
    if test -z $selected
        exit 0
    end

    increase_zoxide_rank "$selected"
    set selected_name (echo "$selected" | tr . -)

    # if the current session doesn't exist and/or tmux isn't runnig create the new session
    if ! tmux has-session -t="$selected_name" 2>/dev/null
        # print info because starting tmux takes a few milliseconds
        if test -z "$(pgrep tmux)"
            echo "Starting tmux..."
        end
        tmux new-session -ds "$selected_name" -c "$XDG_DEVELOPER_DIR/$selected"
    end

    # if we're currently not in tmux attach to the session
    if test -z $TMUX
        tmux attach-session -t "$selected_name"
    else # else switch to it
        tmux switch-client -t "$selected_name"
    end
end

main $argv
