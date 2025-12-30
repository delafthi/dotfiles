{
  imports = [
    ../../../system/darwin
    ../../../system/shared
  ];
  environment.darwinConfig = toString ./configuration.nix;
}
