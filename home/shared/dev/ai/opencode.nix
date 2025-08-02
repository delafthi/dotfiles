{ ollama-base-url, theme, ... }:
{
  programs.opencode = {
    enable = true;
    settings = {
      inherit theme;
      model = "openrouter/qwen/qwen3-coder";
      provider = {
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options.baseURL = ollama-base-url;
          models."qwen2.5-coder:latest".name = "Qwen2.5 Coder";
        };
        openrouter.models = {
          "anthropic/claude-sonnet-4".name = "Claude Sonnet 4";
          "qwen/qwen3-coder".name = "Qwen3 Coder";
        };
      };
    };
  };
}
