{
  imports = [
    ../../../system/nixos
    ../../../system/shared
    ./hardware-configuration.nix
  ];
  nixpkgs.config.allowUnsupportedSystem = true;
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
