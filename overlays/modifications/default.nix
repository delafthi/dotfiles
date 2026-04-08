_final: _prev: {
  bun = import ./bun.nix _final _prev;
  lix = import ./lix.nix _final _prev;
}
