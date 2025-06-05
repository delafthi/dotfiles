{ user, ... }:
{
  imports = [
    ./gpg-agent.nix
    ./homebrew.nix
  ];
  system.primaryUser = user;
}
