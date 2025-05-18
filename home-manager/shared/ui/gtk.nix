{ config, ... }:
{
  gtk = {
    enable = true;
    gtk3 = {
      bookmarks = [
        "file://${config.home.homeDirectory}/Developer"
        "file://${config.xdg.userDirs.download}"
        "file://${config.home.homeDirectory}"
        "file://${config.xdg.userDirs.documents}/00-inbox"
        "file://${config.xdg.userDirs.documents}/01-projects"
        "file://${config.xdg.userDirs.documents}/02-areas"
        "file://${config.xdg.userDirs.documents}/03-resources"
        "file://${config.xdg.userDirs.documents}/04-archives"
      ];
    };
  };
}
