{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    actionlint.enable = true;
    deadnix.enable = true;
    fish_indent.enable = true;
    keep-sorted.enable = true;
    nixfmt.enable = true;
    prettier.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    statix.enable = true;
  };
  settings.formatter = {
    editorconfig-checker = {
      command = pkgs.editorconfig-checker;
      includes = [ "*" ];
      priority = 9; # last
    };
  };
}
