{
  lib,
  stdenv,
  buildGoModule,
  bun,
  fetchFromGitHub,
  fetchurl,
  nix-update-script,
  testers,
}:

let
  version = "0.1.169";
  src = fetchFromGitHub {
    owner = "sst";
    repo = "opencode";
    tag = "v${version}";
    hash = "sha256-XCtO89yj+ov+f1Quof4hCWxL8l4xcFkqRWFW808GiUs=";
  };

  opencode-tui = buildGoModule {
    pname = "opencode-tui";
    inherit version src;

    sourceRoot = "source/packages/tui";

    vendorHash = "sha256-jUxBlBP8eKyDXVvYIZhcrSMfUvGb8/mTPZiPxlCfwLs=";

    subPackages = [ "cmd/opencode" ];

    env.CGO_ENABLED = 0;

    ldflags = [
      "-s"
      "-w"
      "-X=main.Version=${version}"
    ];
  };

  opencode-node-modules-hash = {
    "aarch64-darwin" = "sha256-5Y9bfzYaO1iwSgpkCwPuUCDRtG8uXwgKm98sq78HisI=";
    "aarch64-linux" = "sha256-t7dcyPsWeqYJv4/DPP15bvVurVPGCXWXVPUfpk1+l1Q=";
    "x86_64-darwin" = "sha256-qYljdz4iyl3aZBhVU+uIVx4ZsvY9ubTTLNxJ94TUkBo=";
    "x86_64-linux" = "sha256-TYjcA7MTfOKkvTwGSK1SotMDIH9xag79dikf6hMF8us=";
  };
  node_modules = stdenv.mkDerivation {
    name = "opencode-${version}-node-modules";
    inherit version src;

    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
      "GIT_PROXY_COMMAND"
      "SOCKS_SERVER"
    ];

    nativeBuildInputs = [ bun ];

    dontConfigure = true;

    buildPhase = ''
      bun install --no-cache --no-progress --frozen-lockfile  --filter=opencode
    '';

    installPhase = ''
      mkdir -p $out/node_modules

      cp -R ./node_modules $out
    '';

    # Required else we get errors that our fixed-output derivation references store paths
    dontFixup = true;

    outputHash = opencode-node-modules-hash.${stdenv.hostPlatform.system};
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

  modelsDevData = fetchurl {
    url = "https://models.dev/api.json";
    sha256 = "sha256-+VpQjvOOtuoltE3n9MZn8d0srYDacOh6B4wM0RqBmBM=";
  };
  bun-target = {
    "aarch64-darwin" = "bun-darwin-arm64";
    "aarch64-linux" = "bun-linux-arm64";
    "x86_64-darwin" = "bun-darwin-x64";
    "x86_64-linux" = "bun-linux-x64";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "opencode";
  inherit version src;

  nativeBuildInputs = [ bun ];

  patches = [ ./fix-models-macro.patch ];

  configurePhase = ''
    runHook preConfigure

    cp -R ${node_modules}/node_modules .

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    export MODELS_JSON="$(cat ${modelsDevData})"
    bun build --define OPENCODE_VERSION="'${version}'" --compile --minify --target=${
      bun-target.${stdenv.hostPlatform.system}
    } --outfile=opencode ./packages/opencode/src/index.ts ${opencode-tui}/bin/opencode

    runHook postBuild
  '';

  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp opencode $out/bin/opencode

    runHook postInstall
  '';

  passthru = {
    tests.version = testers.testVersion { package = finalAttrs.finalPackage; };
    updateScript = nix-update-script { };
  };

  meta = {
    description = "AI coding agent built for the terminal";
    longDescription = ''
      OpenCode is a terminal-based agent that can build anything.
      It combines a TypeScript/JavaScript core with a Go-based TUI
      to provide an interactive AI coding experience.
    '';
    homepage = "https://github.com/sst/opencode";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [
      zestsystem
      delafthi
    ];
    mainProgram = "opencode";
  };
})
