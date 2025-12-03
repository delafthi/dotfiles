{
  imports = [
    ./bootloader
    ./desktop
    ./hardware
    ./security
    ./nix.nix
    ./settings
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
