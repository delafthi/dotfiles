{
  stdenvNoCC,
  tmux,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "tmux-scratch-terminal";
  version = "unstable";
  src = ./.;

  buildInputs = [ tmux ];

  installPhase = ''
    runHook preInstall

    install -Dm 755 $src/tmux-scratch-terminal.fish $out/bin/${finalAttrs.name}

    runHook postInstall
  '';
})
