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
      mcp = lib.attrsets.concatMapAttrs (name: value: {
        ${name} = {
          command = [ value.command ] ++ value.args;
          enabled = true;
          type = "local";
        };
      }) config.programs.mcp.servers;
      model = "anthropic/claude-sonnet-4-5";
      provider = {
        anthropic = {
          models = {
            claude-sonnet-4-5 = {
              options = {
                thinking = {
                  type = "enabled";
                  budgetTokens = 16000;
                };
              };
            };
          };
        };
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models."qwen2.5-coder:latest".name = "Qwen2.5 Coder";
        };
      };
      theme = "catppuccin";
    };
  };
}
