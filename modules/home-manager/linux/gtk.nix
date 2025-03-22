{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    font = {
      package = pkgs.noto-fonts;
      name = "Noto Sans";
      size = 12;
    };
    gtk3 = {
      bookmarks = [
        "file://${config.xdg.userDirs.extraConfig.XDG_DEVELOPER_DIR}"
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
