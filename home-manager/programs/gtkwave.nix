{ pkgs ? import <nixpkgs> { } }: {
  home.packages = [ pkgs.gtkwave ];

  home.file.".gtkwaverc".source = ./.gtkwaverc;
  home.file."gtkwave.tcl".source = ./gtkwave.tcl;
}