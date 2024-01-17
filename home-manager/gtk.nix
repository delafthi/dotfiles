{ pkgs ? import <nixpkgs> { } }: {
  gtk = {
    enable = true;
    cursorTheme = {
      package = pkgs.breeze-gtk;
      name = "Breeze_Snow";
      size = 24;
    };
    font = {
      package = pkgs.noto-fonts;
      name = "IosevkaEtoile";
      size = 12;
    };
    gtk3 = {
      bookmarks = [
      ];
    };
    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus-Dark";
    };
    theme = {
      name = "Adwaita-Dark";
    };
  };
}
