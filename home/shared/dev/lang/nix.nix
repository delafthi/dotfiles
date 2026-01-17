{ pkgs, ... }:
{
  home.packages = [ pkgs.manix ];
  nix.registry.templates = {
    from = {
      type = "indirect";
      id = "templates";
    };
    to = {
      type = "github";
      owner = "delafthi";
      repo = "nix-templates";
    };
  };
}
