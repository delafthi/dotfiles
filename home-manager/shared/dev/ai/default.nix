{ lib, ... }:
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
          openai = {
            name = "OpenAI";
            baseURL = "https://api.openai.com/v1";
            envKey = "OPENAI_API_KEY";
          };
          ollama = {
            name = "Ollama";
            baseURL = "http://localhost:11434/v1";
            envKey = "OLLAMA_API_KEY";
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
        default-model = "gpt-4o";
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
          openai = {
            base-url = "https://api.openai.com/v1";
            api-key-env = "OPENAI_API_KEY";
            models = {
              gpt-4o-mini = {
                aliases = [ "4o-mini" ];
                max-input-chars = 504000;
                max-completion-tokens = 2000;
                fallback = "gpt-4o";
              };
              gpt-4o = {
                aliases = [ "4o" ];
                max-input-chars = 496000;
                max-completion-tokens = 4000;
                fallback = "gemma3:4b-it-qat";
              };
            };
          };
          ollama = {
            base-url = "http://localhost:11434/api";
            api-key-env = "OLLAMA_API_KEY";
            models = {
              "qwen3:latest" = {
                aliases = [ "qwen3" ];
                max-input-chars = 112000;
                max-completion-tokens = 4000;
                fallback = "gemma3:4b-it-qat";
              };
              "gemma3:4b-it-qat" = {
                aliases = [ "g3" ];
                max-input-chars = 24000;
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
