{ lib, pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      protonvpn-gui
    ]
    ++ lib.optionals (pkgs.hostPlatform == "x86_64-linux") [
      protonmail-desktop
      proton-pass
    ];
}
