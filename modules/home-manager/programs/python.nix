{pkgs, ...}: {
  home.packages = with pkgs; [
    python3
    python3Packages.uv
  ];
}
