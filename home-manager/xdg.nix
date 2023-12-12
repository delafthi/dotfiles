{ config }: {
  xdg.userDirs = {
    enable = true;
    desktop = null;
    documents = null;
    download = "${config.home.homeDirectory}/0 Inbox/Downloads";
    music = null;
    pictures = "${config.home.homeDirectory}/2 Areas/Pictures";
    publicShare = null;
    templates = "${config.home.homeDirectory}/3 Resources/Templates";
    videos = null;
  };
}
