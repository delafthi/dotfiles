{ lib, pkgs, ... }:
{
  environment = {
    gnome.excludePackages = with pkgs; [
      cheese
      epiphany
      geary
      gnome-tour
      seahorse
      simple-scan
      totem
      yelp
    ];
    systemPackages = with pkgs; [
      nautilus-python
      nautilus-open-any-terminal
    ];
  };
  services = {
    displayManager = {
      enable = true;
      defaultSession = "gnome-xorg";
      gdm.enable = true;
    };
    gnome.gnome-keyring.enable = lib.mkForce false;
    desktopManager = {
      gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
    };
  };
}
