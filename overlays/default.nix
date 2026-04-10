{
  additions =
    final: prev:
    import ../packages {
      inherit (prev) lib;
      pkgs = final;
    };
  modifications = import ./modifications;
}
