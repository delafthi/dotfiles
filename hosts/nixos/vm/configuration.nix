{
  imports = [
    ../../../system/nixos
    ../../../system/shared
    ./hardware-configuration.nix
  ];
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
