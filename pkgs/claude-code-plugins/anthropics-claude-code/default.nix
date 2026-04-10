{ pkgs }:
let
  src = pkgs.fetchFromGitHub {
    owner = "anthropics";
    repo = "claude-code";
    rev = "22fdf68049e8c24e5a36087bb742857d3d5e407d";
    sha256 = "04vnvgm8qabidxdqmiz0cg4z3dyrj7wnsqpgqfipx1mp7bhyipyx";
  };
  pluginNames = builtins.attrNames (
    pkgs.lib.filterAttrs (_: type: type == "directory") (builtins.readDir "${src}/plugins")
  );
  mkPlugin =
    name:
    pkgs.runCommand "claude-code-plugin-${name}" { } ''
      cp -r ${src}/plugins/${name} $out
    '';
in
builtins.listToAttrs (
  map (name: {
    inherit name;
    value = mkPlugin name;
  }) pluginNames
)
