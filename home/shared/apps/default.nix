{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./browser.nix
    ./obsidian.nix
    ./proton.nix
    ./yubikey.nix
  ];
  home.packages =
    with pkgs;
    [ qmk ]
    ++ lib.optionals osConfig.system.gui.enable [
      # blender
      discord
      signal-desktop
      # kicad
    ];
}
