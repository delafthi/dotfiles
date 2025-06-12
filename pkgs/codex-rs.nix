{
  lib,
  rustPlatform,
  fetchFromGitHub,
  openssl,
  pkg-config,
}:
rustPlatform.buildRustPackage {
  pname = "codex-rs";
  version = "0.1.0";

  src =
    (fetchFromGitHub {
      owner = "openai";
      repo = "codex";
      rev = "5fc3c3023d9f179fb416b2722d1434bac278e916";
      hash = "sha256-ZEbcqI3DtV6jZx/wgLqJs4O0sDfHppMwVnfDmE5dXw4=";
    })
    + "/codex-rs";

  useFetchCargoVendor = true;
  cargoHash = "sha256-GBlwoXY5vUjxJx0M3/eiywIxnAVchXACIhNfNCNRZ1k=";

  nativeBuildInputs = [
    pkg-config
    openssl
  ];

  doInstallCheck = true;

  meta = {
    description = "OpenAI Codex command‑line interface rust implementation";
    license = lib.licenses.asl20;
    homepage = "https://github.com/openai/codex";
    changelog = "https://raw.githubusercontent.com/openai/codex/refs/tags/rust-v0.0.2506060849/CHANGELOG.md";
    mainProgram = "codex";
    platforms = lib.platforms.unix;
  };
}
