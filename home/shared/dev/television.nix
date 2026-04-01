{
  programs = {
    nix-search-tv = {
      enable = true;
      settings = {
        indexes = [
          "nixpkgs"
          "home-manager"
          "nixos"
        ];
      };
    };
    television = {
      enable = true;
      settings = {
        history_size = 500;
        ui = {
          use_nerd_font_icons = true;
          ui_scale = 100;
          status_bar.hidden = true;
        };
        shell_integration.channel_triggers = {
          # Filesystem
          "dirs" = [
            "cd"
            "exa"
            "ls"
            "rmdir"
          ]; # override to exclude z/c
          "zoxide" = [
            "c"
            "z"
          ];
          "ssh-hosts" = [
            "ssh"
            "scp"
            "rsync"
          ];

          # Processes
          "procs" = [ "kill" ];

          # Manual pages
          "man-pages" = [ "man" ];
          "tldr" = [ "tldr" ];

          # Build systems
          "just-recipes" = [ "just" ];
          "make-targets" = [ "make" ];

          # Containers
          "podman-images" = [
            "podman run"
            "podman rmi"
            "podman pull"
          ];

          # Git
          "git-branch" = [
            "git checkout"
            "git switch"
            "git merge"
            "git rebase"
            "git branch"
          ];
          "git-log" = [
            "git show"
            "git log"
          ];
          "git-files" = [
            "git add"
            "git restore"
            "git diff"
          ];
          "git-stash" = [
            "git stash pop"
            "git stash apply"
            "git stash show"
          ];
          "git-worktrees" = [ "git worktree" ];

          # GitHub CLI
          "gh-prs" = [
            "gh pr checkout"
            "gh pr view"
            "gh pr review"
            "gh pr merge"
          ];
          "gh-issues" = [
            "gh issue view"
            "gh issue edit"
            "gh issue close"
          ];
        };
      };
      channels = {
        # tv projects — developer projects sorted by frecency
        "projects" = {
          metadata = {
            name = "projects";
            description = "Browse developer projects sorted by frecency";
            requirements = [
              "fd"
              "zoxide"
              "eza"
              "gum"
            ];
          };
          source.command = ''
            fd . "$XDG_DEVELOPER_DIR" --exact-depth 2 --type d |
            sed 's|/$||' |
            awk '
              BEGIN {
                cmd = "zoxide query --list --score 2>/dev/null"
                while ((cmd | getline line) > 0) {
                  n = split(line, a)
                  if (n >= 2) sc[a[2]] = a[1]
                }
                close(cmd)
              }
              { print (($0 in sc) ? sc[$0] : 0), $0 }
            ' |
            sort -rn |
            awk '{ $1=""; sub(/^ /, ""); print }'
          '';
          source.ansi = true;
          source.display = "{split:/:-1} [{split:/:-2}]";
          source.output = "{}";
          preview.command = ''eza --tree --level=2 --color=always "{}"'';
          actions.open = {
            description = "Open project in tmux session";
            command = ''sh -c 'sess="$(basename "$1" | tr . -) [$(basename "$(dirname "$1")")]"; zoxide add "$1" 2>/dev/null; tmux has-session -t "$sess" 2>/dev/null || tmux new-session -ds "$sess" -c "$1"; [ -n "$TMUX" ] && tmux switch-client -t "$sess" || tmux attach-session -t "$sess"' -- '{}' '';
            mode = "execute";
          };
          actions.create = {
            description = "Create new project or clone repository";
            command = ''
              sh -c '
                clear
                input=$(gum input --placeholder "GitHub URL or project name" --header "New project")
                [ -z "$input" ] && exit 0
                pick_ns() {
                  ns=$(printf "%s\n[new namespace]" "$(ls -1 "$XDG_DEVELOPER_DIR")" | \
                    gum filter --header "Namespace for $1")
                  [ -z "$ns" ] && return 1
                  if [ "$ns" = "[new namespace]" ]; then
                    clear
                    ns=$(gum input --placeholder "namespace name" --header "New namespace")
                    [ -z "$ns" ] && return 1
                  fi
                  printf "%s" "$ns"
                }
                if echo "$input" | grep -qE "^(git@|https?://)"; then
                  proj=$(echo "$input" | sed -E "s|.*/||; s|\.git$||")
                  ns=$(pick_ns "$proj") || exit 0
                  mkdir -p "$XDG_DEVELOPER_DIR/$ns"
                  jj git clone "$input" "$XDG_DEVELOPER_DIR/$ns/$proj" || exit 1
                  target="$XDG_DEVELOPER_DIR/$ns/$proj"
                else
                  case "$input" in
                    */*)
                      target="$XDG_DEVELOPER_DIR/$input"
                      mkdir -p "$target"
                      ;;
                    *)
                      ns=$(pick_ns "$input") || exit 0
                      target="$XDG_DEVELOPER_DIR/$ns/$input"
                      mkdir -p "$target"
                      ;;
                  esac
                fi
                zoxide add "$target" 2>/dev/null
                sess="$(basename "$target" | tr . -) [$(basename "$(dirname "$target")")]"
                tmux has-session -t "$sess" 2>/dev/null || tmux new-session -ds "$sess" -c "$target"
                [ -n "$TMUX" ] && tmux switch-client -t "$sess" || tmux attach-session -t "$sess"
              '
            '';
            mode = "execute";
          };
          keybindings.enter = "actions:open";
          keybindings."ctrl-n" = "actions:create";
        };
      };
    };
  };
}
