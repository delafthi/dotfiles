{
  ollama-base-url,
  theme,
  ...
}:
{ config, lib, ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      inherit theme;
      mcp = lib.attrsets.concatMapAttrs (name: value: {
        ${name} = {
          command = [ value.command ] ++ value.args;
          enabled = true;
          type = "local";
        };
      }) config.programs.mcp.servers;
      model = "openrouter/openai/gpt-5-codex";
      provider = {
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = ollama-base-url;
          };
          models."qwen2.5-coder:latest".name = "Qwen2.5 Coder";
        };
        openrouter.models = {
          "openai/gpt-5-codex".name = "GPT-5 Codex";
        };
      };
    };
  };
}
