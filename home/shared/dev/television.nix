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
    };
  };
}
