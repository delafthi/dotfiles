{ user, ... }:
{
  imports = [
    ./homebrew.nix
  ];
  system.primaryUser = user;
}
