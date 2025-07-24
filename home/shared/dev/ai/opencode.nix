{ ollama-base-url, theme, ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      inherit theme;
      "$schema" = "https://opencode.ai/config.json";
      model = "openrouter/anthropic/claude-sonnet-4";
      provider = {
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options.baseURL = ollama-base-url;
          models = {
            "gemma3:4b-it-qat".name = "Gemma3";
            "qwen2.5-coder:latest".name = "Qwen2.5 Coder";
            "qwen3:latest".name = "Qwen3";
          };
        };
        openrouter.models."anthropic/claude-sonnet-4".name = "Claude Sonnet 4";
      };
    };
  };
}
