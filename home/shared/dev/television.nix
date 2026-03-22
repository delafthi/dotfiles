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
            awk -v d="$XDG_DEVELOPER_DIR/" '
              BEGIN {
                cmd = "zoxide query --list --score 2>/dev/null"
                while ((cmd | getline line) > 0) {
                  n = split(line, a)
                  if (n >= 2) sc[a[2]] = a[1]
                }
                close(cmd)
              }
              { s = ($0 in sc) ? sc[$0] : "0.0"; sub(d, ""); print s, $0 }
            ' |
            sort -rnk1 |
            awk '{print $2}'
          '';
          preview.command = "eza --tree --level=2 --color=always \"$XDG_DEVELOPER_DIR/{}\"";
          actions.open = {
            description = "Open project in tmux session";
            command = ''sh -c 'sel="{}"; zoxide add "$XDG_DEVELOPER_DIR/$sel" 2>/dev/null; sess=$(printf "%s" "$sel" | tr . -); tmux has-session -t="$sess" 2>/dev/null || tmux new-session -ds "$sess" -c "$XDG_DEVELOPER_DIR/$sel"; [ -n "$TMUX" ] && tmux switch-client -t "$sess" || tmux attach-session -t "$sess"' '';
            mode = "execute";
          };
          keybindings.enter = "actions:open";
        };
      };
    };
  };
}
