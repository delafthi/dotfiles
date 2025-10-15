{
  ollama-base-url,
  theme,
  ...
}:
{
  config,
  lib,
  nix-ai-tools,
  ...
}:
{
  programs.opencode = {
    enable = true;
    package = nix-ai-tools.opencode;
    settings = {
      inherit theme;
      mcp = lib.attrsets.concatMapAttrs (name: value: {
        ${name} = {
          command = [ value.command ] ++ value.args;
          enabled = true;
          type = "local";
        };
      }) config.programs.mcp.servers;
      model = "openrouter/anthropic/claude-sonnet-4.5";
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
          "anthropic/claude-sonnet-4.5".name = "sonnet-4.5";
        };
      };
    };
  };
}
