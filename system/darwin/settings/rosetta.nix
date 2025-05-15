{
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';
  system.activationScripts.installRosetta.text = ''
    softwareupdate --install-rosetta --agree-to-license
  '';
}
