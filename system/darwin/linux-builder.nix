{
  nix.linux-builder = {
    enable = true;
    config = {
      boot.binfmt.emulatedSystems = [ "x86_64-linux" ];
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 4 * 1024;
        };
        cores = 4;
      };
    };
    ephemeral = true;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
  };
}
