{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      discord
      signal-desktop
      (lib.mkIf (
        pkgs.stdenv.hostPlatform.isDarwin || (pkgs.stdenv.hostPlatform.system == "x86_64-linux")
      ) protonmail-desktop)
    ];
}
