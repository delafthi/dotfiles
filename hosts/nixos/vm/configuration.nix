{
  imports = [
    ../../../system/nixos/bootloader
    ../../../system/nixos/desktop
    ../../../system/nixos/hardware
    ../../../system/nixos/settings
    ../../../system/nixos/state-version.nix
    ../../../system/shared
    ./hardware-configuration.nix
  ];
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
