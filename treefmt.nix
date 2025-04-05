{
  projectRootFile = "flake.nix";
  programs = {
    alejandra.enable = true;
    perltidy.enable = true;
    prettier.enable = true;
    shfmt.enable = true;
  };
}
