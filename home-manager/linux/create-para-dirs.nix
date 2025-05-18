{ config, lib, ... }:
{
  home = {
    activation.createParaDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/00-inbox
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/00-inbox/downloads
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/00-inbox/screenshots
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/01-projects
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/02-areas
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/03-resources
      run mkdir -p $VERBOSE_ARG ${config.xdg.userDirs.documents}/04-archives
    '';
    file.Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/00-inbox/downloads";
  };
}
