{
  stdenvNoCC,
  tmux,
}:
stdenvNoCC.mkDerivation {
  name = "tmux-scratch-terminal";
  version = "unstable";
  src = ./.;

  buildInputs = [ tmux ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tmux-scratch-terminal.fish $out/bin/tmux-scratch-terminal
    chmod +x $out/bin/tmux-scratch-terminal
  '';
}
