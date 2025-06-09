{
  stdenvNoCC,
  fd,
  fzf,
  tmux,
}:
stdenvNoCC.mkDerivation {
  name = "tmux-sessionizer";
  version = "unstable";
  src = ./.;

  buildInputs = [
    fd
    fzf
    tmux
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tmux-sessionizer.sh $out/bin/tmux-sessionizer
    chmod +x $out/bin/tmux-sessionizer
  '';
}
