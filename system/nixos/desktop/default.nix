{
  config,
  lib,
  user,
  ...
}:
lib.mkIf config.system.gui.enable {
  imports = [
    ./sway.nix
    ./swaylock.nix
    ./wayland.nix
    ./xdg-portal.nix
  ];
  users.users.${user}.extraGroups = [ "video" ];

}
