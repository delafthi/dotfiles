{
  stdenvNoCC,
  gh,
  gh-dash,
  tmux,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "tmux-gh-dash";
  version = "unstable";
  src = ./.;

  buildInputs = [
    gh
    gh-dash
    tmux
  ];

  installPhase = ''
    runHook preInstall

    install -Dm755 $src/tmux-gh-dash.fish $out/bin/${finalAttrs.name}

    runHook postInstall
  '';
})
