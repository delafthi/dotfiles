{ pkgs }: {
  programs.bat = {
    enable = true;
    config = {
      theme = "tokyonight_night";
      italic-text = "always";
    };
    themes = {
      tokyonight_night = {
        src = pkgs.fetchFromGitHub {
          owner = "folke";
          repo = "tokyonight.nvim";
          rev = "b262293ef481b0d1f7a14c708ea7ca649672e200";
          sha256 = "sha256-pMzk1gRQFA76BCnIEGBRjJ0bQ4YOf3qecaU6Fl/nqLE=";
        };
        file = "extras/sublime/tokyonight_night.tmTheme";
      };
    };
  };
}
