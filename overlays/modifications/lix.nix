_final: _prev: {
  inherit (_prev.lixPackageSets.stable)
    nixpkgs-review
    nix-eval-jobs
    nix-fast-build
    colmena
    ;
}
