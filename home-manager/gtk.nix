{ config
, pkgs ? import <nixpkgs> { }
}: {
  gtk = {
    enable = true;
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
  };
}
