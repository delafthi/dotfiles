{ pkgs ? import <nixpkgs> { } }: {


  home.packages = [ pkgs.nerd-fonts.iosevka-term-slab ];
  xdg.configFile."ghostty/config".text = ''
    font-family = "IosevkaTermSlab Nerd Font Mono"
    font-size = 14
    theme = tokyonight_night
    window-padding-x = 8
  '';

}
