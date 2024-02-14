{ config
, pkgs ? import <nixpkgs> { }
}: {
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
        "file://${config.home.homeDirectory}/0%20Inbox"
        "file://${config.home.homeDirectory}/1%20Projects"
        "file://${config.home.homeDirectory}/2%20Areas"
        "file://${config.home.homeDirectory}/3%20Resources"
        "file://${config.home.homeDirectory}/4%20Archives"
        "file://${config.home.homeDirectory}/repos"
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
