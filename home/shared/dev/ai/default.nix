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
    ./mcp.nix
  ];
  home.sessionVariables = {
    OPENROUTER_API_KEY = ''$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.openrouter-api-key.path})'';
  };
  programs = {
    mods = {
      enable = true;
      settings = {
        default-api = "openrouter";
        default-model = "openai/gpt-4.1-mini";
        max-input-chars = 32000;
        inherit theme;
        roles =
          let
            readLines = filePath: lib.strings.splitString "\n" (builtins.readFile filePath);
          in
          {
            code-documenter = readLines ./prompts/code-documenter.md;
            code-reviewer = readLines ./prompts/code-reviewer.md;
            commit-message-generator = readLines ./prompts/commit-message-generator.md;
            pipe = readLines ./prompts/pipe.md;
            readme-generator = readLines ./prompts/readme-generator.md;
            test-generator = readLines ./prompts/test-generator.md;
          };
        apis = {
          ollama = {
            base-url = ollama-base-url;
            api-key-env = ollama-api-key-env;
            models = {
              "qwen3:latest".aliases = [ "qwen3" ];
              "gemma3:4b-it-qat".aliases = [ "gemma3" ];
            };
          };
          openrouter = {
            base-url = openrouter-base-url;
            api-key-env = openrouter-api-key-env;
            models = {
              "anthropic/claude-sonnet-4".aliases = [ "claude-sonnet-4" ];
              "openai/gpt-4.1-mini".aliases = [ "gpt-4.1-mini" ];
            };
          };
        };
      };
    };
    opencode = {
      enable = true;
      settings = {
        inherit theme;
        "$schema" = "https://opencode.ai/config.json";
        model = "openrouter/anthropic/claude-sonnet-4";
        provider = {
          ollama = {
            name = "Ollama";
            npm = "@ai-sdk/openai-compatible";
            options.baseURL = ollama-base-url;
            models = {
              "qwen3:latest".name = "Qwen3";
              "gemma3:4b-it-qat".name = "Gemma3";
            };
          };
          openrouter.models."anthropic/claude-sonnet-4".name = "Claude Sonnet 4";
        };
      };
    };
  };
  services.ollama.enable = true;
}
