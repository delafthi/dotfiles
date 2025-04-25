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
      cursor_shape = {
        vi_insert = "line";
        vi_normal = "block";
      };
      edit_mode = "vi";
      history = {
        file_format = "plaintext";
        isolation = false;
        max_size = 100000;
        sync_on_enter = true;
      };
      show_banner = false;
      use_kitty_protocol = true;
    };
  };
}
