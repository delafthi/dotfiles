{
  imports = [
    ./apps
    ./dev
    ./security
    ./settings
    ./nix.nix
    ./user-dirs.nix
    ./user.nix
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
