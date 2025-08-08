{
  config,
  lib,
  pkgs,
  ...
}:
let
  ollama-base-url = "http://localhost:11434";
  ollama-api-key-env = "OLLAMA_API_KEY";
  openrouter-base-url = "https://openrouter.ai/api/v1";
  openrouter-api-key-env = "OPENROUTER_API_KEY";
  theme = "catppuccin";
in
{
  imports = [
    (import ./codex.nix {
      inherit
        ollama-base-url
        ollama-api-key-env
        openrouter-base-url
        openrouter-api-key-env
        ;
    })
    ./mcp.nix
    (import ./mods.nix {
      inherit
        ollama-base-url
        ollama-api-key-env
        openrouter-base-url
        openrouter-api-key-env
        theme
        ;
    })
    (import ./opencode.nix {
      inherit
        ollama-base-url
        ollama-api-key-env
        theme
        ;
    })
  ];
  home.sessionVariables = {
    OPENROUTER_API_KEY = ''$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.openrouter-api-key.path})'';
  };
  services.ollama = {
    enable = true;
    environmentVariables.OLLAMA_CONTEXT_SIZE = "8192";
  };
}
