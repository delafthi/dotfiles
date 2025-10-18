{ lib, pkgs, ... }:
{
  imports = [
    ./iamb.nix
  ];
  home.packages =
    with pkgs;
    lib.optionals (pkgs.hostPlatform.isDarwin || pkgs.hostPlatform == "x86_64-linux") [
      protonmail-desktop
    ];
}
