{ llm-agents, ... }:
{
  home.shellAliases = {
    oc = "opencode";
  };
  programs.opencode = {
    enable = true;
    package = llm-agents.opencode;
    enableMcpIntegration = true;
    settings = {
      keybinds = {
        leader = "ctrl+x";
        session_new = "<leader>c";
        session_compact = "<leader>C";
        session_child_cycle = "<leader>n";
        session_child_cycle_reverse = "<leader>p";
      };
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
    agents = {
      investigate = ./agents/investigate.md;
      review = ./agents/review.md;
      vcs = ./agents/vcs.md;
    };
    commands = {
      codedocs = ./commands/codedocs.md;
      commit = ./commands/commit.md;
      onboard = ./commands/onboard.md;
      pr = ./commands/pr.md;
      readme = ./commands/readme.md;
      review = ./commands/review.md;
      write-tests = ./commands/write-tests.md;
    };
    rules = ./agents.md;
  };
}
