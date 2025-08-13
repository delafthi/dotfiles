{
  stdenvNoCC,
  git,
  glow,
  mods,
}:
stdenvNoCC.mkDerivation (_finalAttrs: {
  name = "code-review";
  version = "unstable";
  src = ./.;

  buildInputs = [
    git
    glow
    mods
  ];

  installPhase = ''
    runHook preInstall

    install -Dm 755 $src/review.fish $out/bin/review

    runHook postInstall
  '';

  meta.mainProgram = "review";
})
