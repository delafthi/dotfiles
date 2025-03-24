{
  config,
  pkgs,
  zen-browser,
  ...
}: {
  imports = [
    ../home.nix
    ./dconf.nix
    ./gtk.nix
    ./xdg.nix
    ./programs
    ./services
  ];

  nixpkgs = {
    config.allowUnsupportedSystem = true;
  };

  home = {
    file.Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/0-inbox/downloads";
    homeDirectory = "/home/delafthi";
    packages = with pkgs; [
      ascii-draw
      blender
      mpv
      proton-pass
      protonmail-desktop
      protonvpn-gui
      virt-manager
      zen-browser.default
    ];
    shellAliases = {
      open = "xdg-open";
    };
  };
  systemd.user.startServices = "sd-switch";
  xsession.enable = true;
}
