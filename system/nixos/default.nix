{
  imports = [
    ./bootloader
    ./desktop
    ./hardware
    ./security
    ./settings
    ./man.nix
    ./nix.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
