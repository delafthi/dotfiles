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
          # Override dirs to exclude z/c — handled by the zoxide channel below
          "dirs" = [
            "cd"
            "ls"
            "rmdir"
          ];
          # Route zoxide commands to the richer zoxide channel (eza preview)
          "zoxide" = [
            "c"
            "z"
          ];
          # Jujutsu change picker
          "jj-log" = [
            "jj edit"
            "jj show"
            "jj squash"
            "jj rebase"
          ];
          # Jujutsu file picker for diff context
          "jj-diff" = [ "jj diff" ];
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
            while IFS= read -r p; do
              p="''${p%/}";
              score=$(zoxide query --list --score "$p" 2>/dev/null | head -1);
              if [ -n "$score" ]; then echo "$score"; else printf '   0.0 %s\n' "$p"; fi;
            done |
            sed "s|$XDG_DEVELOPER_DIR/||" |
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
