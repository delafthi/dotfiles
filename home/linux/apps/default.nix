{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      ascii-draw
      mpv
      protonvpn-gui
      transmission_4-gtk
      virt-manager
    ]
    ++ lib.optionals (pkgs.stdenv.hostPlatform == "x86_64-linux") [
      proton-pass
    ];
}
