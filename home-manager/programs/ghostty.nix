{ pkgs, ... }:
{
  home.packages = [ pkgs.nerd-fonts.iosevka-term-slab ];
  programs.ghostty = {
    enable = true;
    # The ghostty package is currently broken on darwin
    package = if pkgs.hostPlatform.isDarwin then null else pkgs.ghostty;
    settings = {
      cursor-style = "bar";
      font-family = "IosevkaTermSlab Nerd Font Mono";
      font-size = 14;
      macos-option-as-alt = "left";
      window-padding-x = 8;
    };
  };
}
