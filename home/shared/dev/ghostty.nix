{ pkgs, ... }:
{
  home.packages = [ pkgs.nerd-fonts.iosevka-term-slab ];
  programs.ghostty = {
    enable = true;
    # The ghostty package is currently broken on darwin
    package = if pkgs.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    settings = {
      cursor-style = "bar";
      font-family = "IosevkaTermSlab Nerd Font Mono";
      font-size = 14;
      keybind = [
        "cmd+k=text:\\x00k" # opens tmux-sessionizer
      ];
      macos-option-as-alt = "left";
      window-padding-x = 8;
    };
  };
}
