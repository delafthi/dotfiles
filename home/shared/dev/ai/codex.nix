{
  ollama-base-url,
  ollama-api-key-env,
  openrouter-base-url,
  openrouter-api-key-env,
  ...
}:
{ config, ... }:
{
  programs.codex = {
    enable = true;
    settings = {
      model = "openai/gpt-5";
      model_provider = "openrouter";
      approval_policy = "on-failure";
      sandbox_mode = "workspace-write";
      mcp_servers = config.programs.mcp.servers;
      model_providers = {
        ollama = {
          name = "Ollama";
          base_url = ollama-base-url;
          env_key = ollama-api-key-env;
          models = {
            "gemma3n:latest".aliases = [ "gemma3n" ];
            "qwen2.5-coder:latest".aliases = [ "qwen2.5-coder" ];
            "qwen3:latest".aliases = [ "qwen3" ];
          };
        };
        openrouter = {
          name = "OpenRouter";
          base_url = openrouter-base-url;
          env_key = openrouter-api-key-env;
        };
      };
    };
  };
}
