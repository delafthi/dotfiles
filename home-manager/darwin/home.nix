{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../home.nix
    ./darwin.nix
    ./xdg.nix
  ];

  home = {
    file = {
      Documents.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
      Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs/0-inbox/downloads";
      iCloud.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
    };
    homeDirectory = "/Users/delafthi";
    packages = with pkgs; [
      ice-bar
      iina
      podman
      raycast
      utm
    ];
  };
}
