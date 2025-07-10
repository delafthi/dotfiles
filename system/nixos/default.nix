{
  imports = [
    ./bootloader
    ./desktop
    ./hardware
    ./nix.nix
    ./settings
    ./theming.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
