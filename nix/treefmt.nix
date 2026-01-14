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
    mdformat = {
      enable = true;
      plugins = ps: [
        ps.mdformat-frontmatter
      ];
    };
    nixfmt.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;
    statix.enable = true;
    yamlfmt.enable = true;
  };
}
