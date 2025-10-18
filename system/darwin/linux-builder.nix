{
  nix.linux-builder = {
    enable = true;
    config = {
      virtualisation = {
        darwin-builder.memorySize = 4 * 1024;
        cores = 4;
      };
    };
    ephemeral = true;
  };
}
