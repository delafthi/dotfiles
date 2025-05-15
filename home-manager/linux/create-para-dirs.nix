{ config, lib, ... }:
{
  home = {
    activation.createParaDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/0-inbox
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/0-inbox/downloads
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/0-inbox/screenshots
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/1-projects
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/2-areas
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/3-resources
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/4-archives
    '';
    file.Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/0-inbox/downloads";
  };
}
