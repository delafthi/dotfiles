{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      ascii-draw
      mpv
      protonvpn-gui
      virt-manager
    ]
    ++ lib.optionals (pkgs.stdenv.hostPlatform == "x86_64-linux") [
      proton-pass
    ];
}
