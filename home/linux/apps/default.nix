{ osConfig, pkgs, ... }:
{
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      ascii-draw
      mpv
      protonvpn-gui
      virt-manager
      (lib.mkIf (pkgs.stdenv.hostPlatform == "x86_64-linux") proton-pass)
    ];
}
