{
  config,
  tokyonight,
}: {
  home = {
    sessionVariables = {
      # Required on macOS
      EZA_CONFIG_DIR = "${config.home.homeDirectory}/.config/eza";
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
  xdg = {
    configFile."eza/theme.yml".source = "${tokyonight}/extras/eza/tokyonight.yml";
  };
}
