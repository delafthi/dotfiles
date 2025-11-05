{
  imports = [
    ./bootloader
    ./desktop
    ./hardware
    ./user
    ./nix.nix
    ./settings
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
