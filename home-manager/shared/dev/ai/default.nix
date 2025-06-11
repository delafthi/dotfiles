{ lib, ... }:
let
  ollama-base-url = "http://localhost:11434/v1";
  ollama-api-key-env = "OLLAMA_API_KEY";
  openrouter-base-url = "https://openrouter.ai/api/v1";
  openrouter-api-key-env = "OPENROUTER_API_KEY";
in
{
  programs = {
    codex = {
      enable = true;
      settings = {
        model = "gemma3:latest";
        provider = "ollama";
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
      custom-instructions = ''
        - Don't use git; use jujutsu instead
      '';
    };
    mods = {
      enable = true;
      settings = {
        default-model = "o4-mini";
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
              "qwen3:latest" = {
                aliases = [ "local-qwen3" ];
                max-input-chars = 112000;
                max-completion-tokens = 4000;
                fallback = "gemma3:4b-it-qat";
              };
              "gemma3:4b-it-qat" = {
                aliases = [ "local-gemma3" ];
                max-input-chars = 24000;
                max-completion-tokens = 2000;
              };
            };
          };
          openrouter = {
            base-url = openrouter-base-url;
            api-key-env = openrouter-api-key-env;
            models =
              let
                fallback = "google/gemma-3n-e4b-it:free";
              in
              {
                "anthropic/claude-sonnet-4" = {
                  inherit fallback;
                  aliases = [ "sonnet4" ];
                  max-input-chars = 504000;
                  max-completion-tokens = 4000;
                };
                "google/gemini-2.0-flash-001" = {
                  inherit fallback;
                  aliases = [ "gemini2" ];
                  max-input-chars = 504000;
                  max-completion-tokens = 4000;
                };
                "google/gemma-3-27b-it" = {
                  inherit fallback;
                  aliases = [ "gemma3" ];
                  max-input_chars = 112000;
                  max-completion-tokens = 4000;
                };
                "google/gemma-3n-e4b-it:free" = {
                  inherit fallback;
                  aliases = [ "gemma3-free" ];
                  max-input_chars = 24000;
                  max-completion-tokens = 4000;
                };
                "microsoft/phi-4" = {
                  inherit fallback;
                  aliases = [ "phi4" ];
                  max-input-chars = 504000;
                  max-completion-tokens = 2000;
                };
                "microsoft/phi-4-reasoning-plus:free" = {
                  inherit fallback;
                  aliases = [ "phi4-free" ];
                  max-input-chars = 504000;
                  max-completion-tokens = 2000;
                };
                "mistralai/devstral-small:free" = {
                  inherit fallback;
                  aliases = [ "devstral-free" ];
                  max-input-chars = 24000;
                  max-completion-tokens = 2000;
                };
                "openai/gpt-4o-mini" = {
                  inherit fallback;
                  aliases = [ "4o-mini" ];
                  max-input-chars = 504000;
                  max-completion-tokens = 2000;
                };
              };
          };
        };
      };
    };
  };
  services.ollama.enable = true;
}
