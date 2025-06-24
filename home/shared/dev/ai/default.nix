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
in
{
  home.sessionVariables = {
    OPENROUTER_API_KEY = ''$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.openrouter-api-key.path})'';
  };
  programs = {
    codex = {
      enable = true;
      settings = {
        model = "openai/gpt-4.1";
        provider = "openrouter";
        approvalMode = "suggest";
        fullAutoErrorMode = "ask-user";
        notify = true;
        providers = {
          ollama = {
            name = "Ollama";
            baseURL = ollama-base-url;
            envKey = ollama-api-key-env;
          };
          openrouter = {
            name = "OpenRouter";
            baseURL = openrouter-base-url;
            envKey = openrouter-api-key-env;
          };
        };
        history = {
          maxSize = 1000;
          saveHistory = true;
        };
      };
    };
    mods = {
      enable = true;
      settings = {
        default-model = "openai/gpt-4o-mini";
        default-api = "openrouter";
        max-input-chars = 392200;
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
              "google/gemini-2.0-flash-001".aliases = [ "gemini-2.0-flash" ];
              "microsoft/phi-4".aliases = [ "phi-4" ];
              "openai/gpt-4.1-mini".aliases = [ "gpt-4.1-mini" ];
              "openai/gpt-4o-mini".aliases = [ "gpt-4o-mini" ];
            };
          };
        };
      };
    };
  };
  services.ollama.enable = true;
}
