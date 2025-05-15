{
  imports = [
    ../../../system/darwin
    ../../../system/shared
  ];
  environment.darwinConfig = builtins.toString ./configuration.nix;
}
