{ config, ... }:
{
  gtk = {
    enable = true;
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Developer"
        "file://${config.xdg.userDirs.download}"
        "file://${config.home.homeDirectory}"
        "file://${config.xdg.userDirs.documents}/0-inbox"
        "file://${config.xdg.userDirs.documents}/1-projects"
        "file://${config.xdg.userDirs.documents}/2-areas"
        "file://${config.xdg.userDirs.documents}/3-resources"
        "file://${config.xdg.userDirs.documents}/4-archives"
      ];
    };
  };
}
