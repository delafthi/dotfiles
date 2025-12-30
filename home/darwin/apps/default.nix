{
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./ux.nix
  ];
  home.packages =
    with pkgs;
    lib.optionals osConfig.system.gui.enable [
      alcove
      aldente
      iina
      lunar
      meetingbar
      monodraw
      shottr
      utm
    ];
}
