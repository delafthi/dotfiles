{
  stdenvNoCC,
  tmux,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "tmux-change-session-dir";
  version = "unstable";
  src = ./.;

  buildInputs = [ tmux ];

  installPhase = ''
    runHook preInstall

    install -Dm 755 $src/tmux-change-session-dir.fish $out/bin/${finalAttrs.name}

    runHook postInstall
  '';
})
