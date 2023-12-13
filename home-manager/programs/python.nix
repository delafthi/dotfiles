{ pkgs ? import <nixpkgs> { } }: {
  home.packages = with pkgs; [
    python3
  ];
}
