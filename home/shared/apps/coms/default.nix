{ lib, pkgs, ... }:
{
  imports = [
    ./iamb.nix
  ];
  home.packages =
    with pkgs;
    lib.optionals (pkgs.stdenv.hostPlatform.isDarwin || pkgs.stdenv.hostPlatform == "x86_64-linux") [
      protonmail-desktop
    ];
}
