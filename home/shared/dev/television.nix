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
          keybindings.enter = "actions:open";
        };
      };
    };
  };
}
