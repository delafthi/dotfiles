{
  projectRootFile = "flake.nix";
  programs = {
    nixfmt.enable = true;
    perltidy.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
  };
}
