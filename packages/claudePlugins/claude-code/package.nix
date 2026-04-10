{
  fetchFromGitHub,
  lib,
  stdenvNoCC,
  nix-update-script,
}:
let
  version = "2.1.104";
  src = fetchFromGitHub {
    owner = "anthropics";
    repo = "claude-code";
    tag = "v${version}";
    sha256 = "sha256-Ir8bikRS0YSwEE2IGtpHE7G1pe94V38h74ubatyM1GM=";
  };
  pluginNames = builtins.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir "${src}/plugins")
  );
  mkPlugin =
    name:
    stdenvNoCC.mkDerivation {
      pname = "claude-code-${name}";
      inherit version src;

      installPhase = ''
        cp -r plugins/${name} $out
      '';

      passthru.updateScript = nix-update-script { };

      meta = {
        description = "Claude Code plugin: ${name}";
        license = lib.licenses.mit;
        maintainers = [ lib.maintainers.delafthi ];
        platforms = lib.platforms.all;
        sourceProvenance = [ lib.sourceTypes.fromSource ];
        changelog = "https://github.com/anthropics/claude-code/blob/v${version}/CHANGELOG.md";
      };
    };
in
lib.genAttrs pluginNames mkPlugin
