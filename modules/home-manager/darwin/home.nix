{ lib
, config
, pkgs
, tokyonight
, ...
}: {
  imports = [
    (import ../home.nix { inherit lib config pkgs tokyonight; })
    ./darwin.nix
    (import ./programs/gpg.nix { inherit pkgs; })
  ];

  home = {
    activation = {
      createTemplatesDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        run mkdir -p $VERBOSE_ARG ${config.home.homeDirectory}/Templates
      '';
    };
    file = {
      Documents.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
      Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs/0-inbox/downloads";
      iCloud.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
    };
    homeDirectory = "/Users/delafthi";
    sessionVariables = {
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
}
