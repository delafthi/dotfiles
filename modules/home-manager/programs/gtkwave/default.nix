{pkgs, ...}: {
  home = {
    file.".gtkwaverc".source = ./.gtkwaverc;
    file."gtkwave.tcl".source = ./gtkwave.tcl;
    packages = [pkgs.gtkwave];
  };
}
