{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable (
      [
        proton-vpn
      ]
      ++ lib.optionals (pkgs.stdenv.hostPlatform == "x86_64-linux" || pkgs.stdenv.hostPlatform.isDarwin) [
        protonmail-desktop
        proton-pass
      ]
    );
}
