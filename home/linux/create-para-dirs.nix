{ config, lib, ... }:
let
  mkdir = dir: ''[[ -L "${dir}" ]] || run mkdir -p $VERBOSE_ARG "${dir}"'';
in
{
  home = {
    activation.createParaDirectories = lib.hm.dag.entryAfter [ "linkGeneration" ] (
      lib.strings.concatMapStringsSep "\n" mkdir [
        "${config.xdg.userDirs.documents}/00-inbox"
        "${config.xdg.userDirs.documents}/00-inbox/downloads"
        "${config.xdg.userDirs.documents}/00-inbox/screenshots"
        "${config.xdg.userDirs.documents}/01-projects"
        "${config.xdg.userDirs.documents}/02-areas"
        "${config.xdg.userDirs.documents}/03-resources"
        "${config.xdg.userDirs.documents}/04-archives"
      ]
    );
    file.Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/00-inbox/downloads";
  };
}
