{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_DEVELOPER_DIR = "$HOME/Developer";
        XDG_MOVIES_DIR = "$HOME/Movies";
      };
      videos = "$HOME/Movies";
    };
  };
}
