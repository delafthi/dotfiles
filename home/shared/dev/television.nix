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
    };
  };
}
