{
  additions = final: _: import ../packages { inherit (final) pkgs; };
  modifications = import ./modifications;
}
