{
  config,
  pkgs,
  ...
}:
{
  home = {
    sessionVariables = {
      # Required on macOS
      EZA_CONFIG_DIR = "${config.home.homeDirectory}/.config/eza";
      LS_COLORS = "$(${pkgs.vivid}/bin/vivid generate catppuccin-${config.catppuccin.flavor})";
    };
  };
  programs.eza = {
    enable = true;
    extraOptions = [
      "--group-directories-first"
    ];
    git = true;
    icons = "auto";
  };
}
