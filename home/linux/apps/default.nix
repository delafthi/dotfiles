{ osConfig, pkgs, ... }:
{
  imports = [
    ./zathura.nix
  ];
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      ascii-draw
      protonvpn-gui
      virt-manager
      (lib.mkIf (pkgs.stdenv.hostPlatform == "x86_64-linux") proton-pass)
    ];
  programs = {
    imv.enable = osConfig.system.gui.enable;
    mpv.enable = osConfig.system.gui.enable;
  };
}
