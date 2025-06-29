{
  imports = [
    ../../../system/nixos
    ../../../system/shared
    ./hardware-configuration.nix
  ];
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  nixpkgs.config.allowUnsupportedSystem = true;
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };
}
