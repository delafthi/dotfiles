{pkgs}: {
  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      {package = keep-awake;}
      {package = dash-to-dock;}
    ];
  };
}
