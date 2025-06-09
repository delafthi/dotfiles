{
  stdenvNoCC,
  fd,
  fish,
  fzf,
  ripgrep,
  sd,
  tmux,
}:
stdenvNoCC.mkDerivation {
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
    mkdir -p $out/bin
    cp $src/tmux-sessionizer.fish $out/bin/tmux-sessionizer
    chmod +x $out/bin/tmux-sessionizer
  '';
}
