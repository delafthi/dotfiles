{ pkgs, ... }:
{
  programs.nushell = {
    enable = true;
    plugins = with pkgs.nushellPlugins; [
      formats
      query
      units
    ];
    settings = {
      completions = {
        algorithm = "fuzzy";
      };
      history = {
        isolation = false;
        max_size = 100000;
        sync_on_enter = true;
      };
      show_banner = false;
      use_kitty_protocol = true;
    };
  };
}
