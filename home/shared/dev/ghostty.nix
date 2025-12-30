{
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.mkIf osConfig.system.gui.enable {
  home.packages = [ pkgs.nerd-fonts.iosevka-term-slab ];
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      cursor-style = "bar";
      font-family = "IosevkaTermSlab Nerd Font Mono";
      font-size = 14;
      keybind = [
        "cmd+k=text:\\x00k"
      ];
      macos-option-as-alt = "left";
      mouse-scroll-multiplier = "1";
      window-inherit-working-directory = false;
      window-padding-x = 8;
    };
  };
}
