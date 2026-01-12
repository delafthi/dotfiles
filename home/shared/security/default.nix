{ ... }:
{
  imports = [
    ./gpg.nix
    ./gpg-agent.nix
    ./password-store.nix
    ./proton-pass-agent.nix
    ./sops.nix
  ];
}
