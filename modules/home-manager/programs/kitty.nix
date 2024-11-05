{ pkgs ? import <nixpkgs> { } }: {

  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "IosevkaTermSlab" ]; });
      name = "IosevkaTermSlab Nerd Font Mono";
      size = 14;
    };
    settings = {
      disable_ligatures = "cursor";
      scrollback_lines = 10000;
      update_check_interval = 0;
      window_padding_width = 8;
    };
    themeFile = "tokyo_night_night";
  };
}
