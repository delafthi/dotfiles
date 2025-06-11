{ lib, ... }:
let
  ollama-base-url = "http://localhost:11434";
  ollama-api-key-env = "OLLAMA_API_KEY";
  openrouter-base-url = "https://openrouter.ai/api/v1";
  openrouter-api-key-env = "OPENROUTER_API_KEY";
in
{
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
            models =
              let
                fallback = "gemma3:4b-it-qat";
              in
              {
                "qwen3:latest" = {
                  inherit fallback;
                  aliases = [ "qwen3" ];
                  # “Qwen3” has a 32 K token context window → ≃ 32 000 tokens * 4 chars/token
                  max-input-chars = 28000 * 4; # -> 112000 chars
                  max-completion-tokens = 4000; # give it up to 4 K for the completion
                };

                "gemma3:4b-it-qat" = {
                  inherit fallback;
                  aliases = [ "gemma3" ];
                  # “Gemma3 4b-it-qat” has an 8 K token context window → ≃ 8 000 tokens * 4 chars/token
                  max-input-chars = 6000 * 4; # -> 24000 chars
                  max-completion-tokens = 2000; # give it up to 2 K for the completion
                };
              };
          };
          openrouter = {
            base-url = openrouter-base-url;
            api-key-env = openrouter-api-key-env;
            models =
              let
                fallback = "openai/gpt-4o-mini";
              in
              {
                "anthropic/claude-sonnet-4" = {
                  inherit fallback;
                  aliases = [ "sonnet4" ];
                  # “Sonnet” has a 64 K token context window → ≃ 64 000 tokens * 4 chars/token
                  max-input-chars = 64000 * 4; # -> 256000 chars
                  max-completion-tokens = 8192; # give it up to 8 K for the completion
                };
                "google/gemini-2.0-flash-001" = {
                  inherit fallback;
                  aliases = [ "gemini2" ];
                  # “Flash” has an 8 K token context window → ≃ 8 000 tokens * 4 chars/token
                  max-input-chars = 8000 * 4; # -> 32000 chars
                  max-completion-tokens = 1024; # give it up to 1 K for the completion
                };
                "microsoft/phi-4" = {
                  inherit fallback;
                  aliases = [ "phi4" ];
                  # “Phi-4” has a 32 K token context window → ≃ 32 000 tokens * 4 chars/token
                  max-input-chars = 32000 * 4; # -> 128000 chars
                  max-completion-tokens = 8192; # give it up to 8 K for the completion
                };
                "openai/gpt-4.1-mini" = {
                  inherit fallback;
                  aliases = [ "4.1-mini" ];
                  # “GPT-4.1-mini” has an 8 K token context window → ≃ 8 000 tokens * 4 chars/token
                  max-input-chars = 8000 * 4; # -> 32000 chars
                  max-completion-tokens = 2048; # give it up to 2 K for the completion
                };
                "openai/gpt-4o-mini" = {
                  inherit fallback;
                  aliases = [ "4o-mini" ];
                  # “GPT-4o-mini” has an 8 K token context window → ≃ 8 000 tokens * 4 chars/token
                  max-input-chars = 8000 * 4; # -> 32000 chars
                  max-completion-tokens = 2048; # give it up to 2 K for the completion
                };
              };
          };
        };
      };
    };
  };
  services.ollama.enable = true;
}
