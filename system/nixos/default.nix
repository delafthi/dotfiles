{
  imports = [
    ./bootloader
    ./desktop
    ./hardware
    ./programs
    ./security
    ./settings
    ./nix.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
