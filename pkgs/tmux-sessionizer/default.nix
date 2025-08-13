{
  stdenvNoCC,
  fd,
  fish,
  fzf,
  ripgrep,
  sd,
  tmux,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "tmux-sessionizer";
  version = "unstable";
  src = ./.;

  buildInputs = [
    fd
    fish
    fzf
    ripgrep
    sd
    tmux
  ];

  installPhase = ''
    runHook preInstall

    install -Dm 755 $src/tmux-sessionizer.fish $out/bin/${finalAttrs.name}

    runHook postInstall
  '';
})
