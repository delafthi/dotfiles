{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    # Required on macOS
    EZA_CONFIG_DIR = "$XDG_CONFIG_HOME/eza";
    LS_COLORS = "$(${lib.getExe pkgs.vivid} generate catppuccin-${config.catppuccin.flavor})";
  };
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
    ];
    icons = "auto";
  };
}
