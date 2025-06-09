{
  stdenvNoCC,
  gh,
  gh-dash,
  tmux,
}:
stdenvNoCC.mkDerivation {
  name = "tmux-gh-dash";
  version = "unstable";
  src = ./.;

  buildInputs = [
    gh
    gh-dash
    tmux
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/tmux-gh-dash.fish $out/bin/tmux-gh-dash
    chmod +x $out/bin/tmux-gh-dash
  '';
}
