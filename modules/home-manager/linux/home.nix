{
  lib,
  config,
  pkgs,
  tokyonight,
  ...
}: {
  imports = [
    (import ../home.nix {inherit lib config pkgs tokyonight;})
    (import ./dconf.nix {inherit lib;})
    (import ./gtk.nix {inherit config pkgs;})
    (import ./services.nix {inherit pkgs;})
    ./xdg.nix
  ];
  home = {
    file.Downloads.source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Documents/0-inbox/downloads";
    homeDirectory = "/home/delafthi";
    packages = with pkgs; [
      ascii-draw
      blender
      brave
      gnomeExtensions.keep-awake
      godot_4
      mpv
      proton-pass
      protonmail-desktop
      protonvpn-gui
      ulauncher
    ];
    shellAliases = {
      open = "xdg-open";
    };
  };
  xsession.enable = true;
  systemd.user.startServices = "sd-switch";
}
