{
  config,
  lib,
  pkgs,
  ...
}:
let
  ollama-base-url = "http://localhost:11434/v1";
  openrouter-base-url = "https://openrouter.ai/api/v1";
  openrouter-api-key-env = "OPENROUTER_API_KEY";
  theme = "catppuccin";
in
{
  imports = [
    ./mcp.nix
    (import ./mods.nix {
      inherit
        ollama-base-url
        openrouter-base-url
        openrouter-api-key-env
        theme
        ;
    })
    (import ./opencode.nix {
      inherit
        ollama-base-url
        theme
        ;
    })
  ];
  home = {
    packages = with pkgs; [ code-review ];
    sessionVariables = {
      OPENROUTER_API_KEY = ''$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.openrouter-api-key.path})'';
    };
  };
  services.ollama = {
    enable = false;
    environmentVariables.OLLAMA_CONTEXT_SIZE = "8192";
  };
}
