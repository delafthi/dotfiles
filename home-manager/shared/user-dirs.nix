{
  config,
  lib,
  pkgs,
  user,
  ...
}:
{
  home = {
    activation =
      {
        createDeveloperDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p $VERBOSE_ARG ${config.home.homeDirectory}/Developer
        '';
      }
      // lib.optionalAttrs pkgs.hostPlatform.isDarwin {
        createTemplatesDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          run mkdir -p $VERBOSE_ARG ${config.home.homeDirectory}/Templates
        '';
      };
    homeDirectory = if pkgs.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";
    preferXdgDirectories = true;
    sessionVariables =
      if pkgs.hostPlatform.isDarwin then
        {
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
        }
      else
        { };
  };
  xdg =
    {
      enable = true;
    }
    // lib.optionalAttrs pkgs.hostPlatform.isLinux {
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
