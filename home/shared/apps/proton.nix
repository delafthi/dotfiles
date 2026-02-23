{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  home.packages =
    with pkgs;
    [ ]
    ++ lib.optionals osConfig.system.gui.enable [
      (lib.mkIf (
        pkgs.stdenv.hostPlatform == "x86_64-linux" || pkgs.stdenv.hostPlatform.isDarwin
      ) proton-pass)
      proton-vpn
    ];
}
