{
  imports = [
    ../../../system/nixos
    ../../../system/shared
    ./hardware-configuration.nix
  ];
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
  services.spice-vdagentd.enable = true;
  virtualisation.rosetta.enable = true;
}
