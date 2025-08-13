{
  additions = final: _: import ../pkgs { inherit (final) pkgs; };
  modifications = import ./modifications;
}
