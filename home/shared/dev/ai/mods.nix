{
  ollama-base-url,
  openrouter-base-url,
  openrouter-api-key-env,
  theme,
  ...
}:
{ config, lib, ... }:
{
  programs.mods = {
    enable = true;
    settings = {
      default-api = "openrouter";
      default-model = "openai/gpt-5-mini";
      max-input-chars = 32000;
      mcp-servers = config.programs.mcp.servers;
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
          base-url = lib.removeSuffix "/v1" ollama-base-url;
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
            "openai/gpt-5".aliases = [ "gpt-5" ];
            "openai/gpt-5-mini".aliases = [ "gpt-5-mini" ];
          };
        };
      };
    };
  };
}
