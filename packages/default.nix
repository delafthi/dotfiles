{ lib, pkgs }:
let
  readPackages =
    dir:
    lib.mapAttrs (
      name: _:
      let
        sub = dir + "/${name}";
      in
      if builtins.pathExists (sub + "/package.nix") then
        pkgs.callPackage (sub + "/package.nix") { }
      else
        readPackages sub
    ) (lib.filterAttrs (_: t: t == "directory") (builtins.readDir dir));
in
readPackages ./.
