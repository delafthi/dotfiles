{
  config,
  lib,
  pkgs,
  ...
}:
let
  openrouter-api-key-env = "OPENROUTER_API_KEY";
in
{
  imports = [
    ./opencode
    ./mcp.nix
  ];
  programs = {
    bash.initExtra = ''
      export ${openrouter-api-key-env}=$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${
        config.sops.secrets."api-keys/openrouter".path
      })
    '';
    fish.interactiveShellInit = ''
      set -gx ${openrouter-api-key-env} (${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${
        config.sops.secrets."api-keys/openrouter".path
      })
    '';
  };
  services.ollama = {
    enable = false;
    environmentVariables.OLLAMA_CONTEXT_SIZE = "8192";
  };
}
