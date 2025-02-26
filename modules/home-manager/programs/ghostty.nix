{ pkgs }: {


  home.packages = [ pkgs.nerd-fonts.iosevka-term-slab ];
  programs.ghostty = {
    enable = true;
    package = null;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    settings = {
      font-family = "IosevkaTermSlab Nerd Font Mono";
      font-size = 14;
      macos-option-as-alt = false;
      theme = "tokyonight_night";
      window-padding-x = 8;
    };
  };
}
