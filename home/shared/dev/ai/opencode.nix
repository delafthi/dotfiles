{
  ollama-base-url,
  ollama-api-key-env,
  theme,
  ...
}:
{
  programs.opencode = {
    enable = true;
    settings = {
      inherit theme;
      model = "openrouter/openai/gpt-5";
      provider = {
        ollama = {
          name = "Ollama";
          npm = "@ai-sdk/openai-compatible";
          options = {
            baseURL = ollama-base-url;
            apiKey = "{env:${ollama-api-key-env}}";
          };
          models."qwen2.5-coder:latest".name = "Qwen2.5 Coder";
        };
        openrouter.models = {
          "anthropic/claude-sonnet-4".name = "Claude Sonnet 4";
          "openai/gpt-5".name = "GPT-5";
        };
      };
    };
  };
}
