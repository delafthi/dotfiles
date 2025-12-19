{
  imports = [
    ./hardware
    ./settings
    ./user
    ./linux-builder.nix
    ./nix.nix
  ];

  # https://nix-darwin.github.io/nix-darwin/manual/index.html#opt-system.stateVersion
  system.stateVersion = 4;
}
