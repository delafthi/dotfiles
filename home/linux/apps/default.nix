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
      virt-manager
    ];
  programs = {
    mpv.enable = osConfig.system.gui.enable;
  };
}
