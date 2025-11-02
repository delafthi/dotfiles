{
  lib,
  stdenvNoCC,
  fetchurl,
  common-updater-scripts,
  curl,
  installShellFiles,
  jq,
  unzip,
  testers,
  writeShellScript,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "opencode";
  version = "1.0.11";

  src =
    finalAttrs.passthru.sources.${stdenvNoCC.hostPlatform.system}
      or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");
  sourceRoot = ".";

  strictDeps = true;
  nativeBuildInputs = [
    unzip
    installShellFiles
  ];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm 755 ./opencode $out/bin/opencode

    runHook postInstall
  '';

  passthru = {
    sources = {
      "aarch64-darwin" = fetchurl {
        url = "https://github.com/sst/opencode/releases/download/v${finalAttrs.version}/opencode-darwin-arm64.zip";
        hash = "sha256-YZfumfaNSMIrM6SmaxTG2VH/kTZCSUouXJMtb5XELIY=";
      };
      "aarch64-linux" = fetchurl {
        url = "https://github.com/sst/opencode/releases/download/v${finalAttrs.version}/opencode-linux-arm64.zip";
        hash = "sha256-m2xuAxfQf/ouEDN25pDSbPS1GbjjT9AKcbUKK+Z10gU=";
      };
      "x86_64-darwin" = fetchurl {
        url = "https://github.com/sst/opencode/releases/download/v${finalAttrs.version}/opencode-darwin-x64.zip";
        hash = "sha256-9gBUNrbHAs2VAKt4WwemsvgzEUtE7sYFjJW91D+wptY=";
      };
      "x86_64-linux" = fetchurl {
        url = "https://github.com/sst/opencode/releases/download/v${finalAttrs.version}/opencode-linux-x64.zip";
        hash = "sha256-n9at0vE65hVj4VeYZ6kF3hvni6WTatVxRaLaOXFQpzA=";
      };
    };
    tests.version = testers.testVersion {
      package = finalAttrs.finalPackage;
      command = "HOME=$(mktemp -d) opencode --version";
      inherit (finalAttrs) version;
    };
    updateScript = writeShellScript "update-opencode" ''
      set -o errexit
      export PATH="${
        lib.makeBinPath [
          curl
          jq
          common-updater-scripts
        ]
      }"
      NEW_VERSION=$(curl --silent https://api.github.com/repos/sst/opencode/releases/latest | jq '.tag_name | ltrimstr("v")' --raw-output)
      if [[ "${finalAttrs.version}" = "$NEW_VERSION" ]]; then
          echo "No update available."
          exit 0
      fi
      for platform in ${lib.escapeShellArgs finalAttrs.meta.platforms}; do
        update-source-version "opencode" "$NEW_VERSION" --ignore-same-version --source-key="sources.$platform"
      done
    '';
  };

  meta = {
    description = "AI coding agent built for the terminal";
    changelog = "https://github.com/sst/opencode/releases/tag/v${finalAttrs.version}";
    longDescription = ''
      OpenCode is a terminal-based agent that can build anything.
      It combines a TypeScript/JavaScript core with a Go-based TUI
      to provide an interactive AI coding experience.
    '';
    homepage = "https://github.com/sst/opencode";
    license = lib.licenses.mit;
    platforms = builtins.attrNames finalAttrs.passthru.sources;
    maintainers = with lib.maintainers; [
      zestsystem
      delafthi
    ];
    mainProgram = "opencode";
  };
})
