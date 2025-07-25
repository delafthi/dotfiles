{
  config,
  lib,
  pkgs,
  user,
  ...
}:
let
  mkdir = dir: ''[[ -L "${dir}" ]] || run mkdir -p $VERBOSE_ARG "${dir}"'';
in
{
  home = {
    activation = {
      createDeveloperDirectory = lib.hm.dag.entryAfter [ "linkGeneration" ] (
        mkdir "${config.home.homeDirectory}/Developer"
      );
    }
    // lib.optionalAttrs pkgs.hostPlatform.isDarwin {
      createXdgUserDirectories = lib.hm.dag.entryAfter [ "linkGeneration" ] (
        lib.strings.concatMapStringsSep "\n" mkdir [
          "${config.home.homeDirectory}/Desktop"
          "${config.home.homeDirectory}/Documents"
          "${config.home.homeDirectory}/Downloads"
          "${config.home.homeDirectory}/Music"
          "${config.home.homeDirectory}/Movies"
          "${config.home.homeDirectory}/Pictures"
          "${config.home.homeDirectory}/Public"
          "${config.home.homeDirectory}/Templates"
          "${config.home.homeDirectory}/Templates"
        ]
      );
    };
    homeDirectory = if pkgs.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";
    preferXdgDirectories = true;
    sessionVariables = lib.optionalAttrs pkgs.hostPlatform.isDarwin {
      # define xdg userdirs here because the userdirs module is only available on linux
      XDG_DEVELOPER_DIR = "$HOME/Developer";
      XDG_DESKTOP_DIR = "$HOME/Desktop";
      XDG_DOCUMENTS_DIR = "$HOME/Documents";
      XDG_DOWNLOAD_DIR = "$HOME/Downloads";
      XDG_MUSIC_DIR = "$HOME/Music";
      XDG_MOVIES_DIR = "$HOME/Movies";
      XDG_PICTURES_DIR = "$HOME/Pictures";
      XDG_PUBLICSHARE_DIR = "$HOME/Public";
      XDG_TEMPLATES_DIR = "$HOME/Templates";
      XDG_VIDEOS_DIR = "$HOME/Movies";
    };
  };
  xdg = {
    enable = true;
    userDirs = lib.optionalAttrs pkgs.hostPlatform.isLinux {
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
