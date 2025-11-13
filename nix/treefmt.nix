{ pkgs, ... }:
{
  projectRootFile = "flake.nix";
  programs = {
    actionlint.enable = true;
    biome = {
      enable = true;
      settings.formatter.indentStyle = "space";
    };
    deadnix.enable = true;
    fish_indent.enable = true;
    just.enable = true;
    keep-sorted.enable = true;
    mdformat.enable = true;
    nixfmt.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    statix.enable = true;
    yamlfmt.enable = true;
  };
  settings.formatter = {
    editorconfig-checker = {
      command = pkgs.editorconfig-checker;
      includes = [ "*" ];
      priority = 9; # last
    };
  };
}
