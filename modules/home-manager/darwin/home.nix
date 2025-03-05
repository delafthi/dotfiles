{
  lib,
  config,
  pkgs,
  tokyonight,
  ...
}: {
  imports = [
    (import ../home.nix {inherit lib config pkgs tokyonight;})
    ./darwin.nix
    ./programs/ghostty.nix
    (import ./programs/gpg-agent.nix {inherit pkgs;})
    (import ./xdg.nix {inherit lib config;})
  ];

  home = {
    file = {
      Documents.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
      Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs/0-inbox/downloads";
      iCloud.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
    };
    homeDirectory = "/Users/delafthi";
    packages = with pkgs; [
      iina
      ice-bar
      podman
    ];
  };
}
