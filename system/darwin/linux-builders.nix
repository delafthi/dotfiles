{
  nix.linux-builder = {
    enable = true;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
