{
  ollama-base-url,
  ollama-api-key-env,
  openrouter-base-url,
  openrouter-api-key-env,
  theme,
  ...
}:
{ lib, ... }:
{
  programs.mods = {
    enable = true;
    settings = {
      default-api = "openrouter";
      default-model = "qwen/qwen3-235b-a22b-07-25";
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
            "gemma3n:latest".aliases = [ "gemma3n" ];
            "qwen2.5-coder:latest".aliases = [ "qwen2.5-coder" ];
            "qwen3:latest".aliases = [ "qwen3" ];
          };
        };
        openrouter = {
          base-url = openrouter-base-url;
          api-key-env = openrouter-api-key-env;
          models = {
            "anthropic/claude-sonnet-4".aliases = [ "claude-sonnet-4" ];
            "openai/gpt-4.1-mini".aliases = [ "gpt-4.1-mini" ];
            "qwen/qwen3-235b-a22b-07-25".aliases = [ "qwen3" ];
            "qwen/qwen3-coder".aliases = [ "qwen3-coder" ];
          };
        };
      };
    };
  };
}
