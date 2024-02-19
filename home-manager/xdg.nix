{ config }: {
  xdg.userDirs = {
    enable = true;
    desktop = null;
    documents = null;
    download = "${config.home.homeDirectory}/0-inbox/downloads";
    music = null;
    pictures = "${config.home.homeDirectory}/2-areas/pictures";
    publicShare = null;
    templates = "${config.home.homeDirectory}/3-resources/templates";
    videos = null;
  };
}
