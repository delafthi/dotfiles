{ osConfig, pkgs, ... }:
{
  imports = [
    ./imv.nix
    ./zathura.nix
  ];
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      ascii-draw
      protonvpn-gui
      virt-manager
    ];
  programs = {
    mpv.enable = osConfig.system.gui.enable;
  };
}
