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
        "file://${config.home.homeDirectory}/0-inbox"
        "file://${config.home.homeDirectory}/1-projects"
        "file://${config.home.homeDirectory}/2-areas"
        "file://${config.home.homeDirectory}/3-resources"
        "file://${config.home.homeDirectory}/4-archives"
        "file://${config.home.homeDirectory}/repos"
      ];
    };
  };
}
