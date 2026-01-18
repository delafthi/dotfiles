{ llm-agents, ... }:
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    package = llm-agents.claude-code;
    settings = {
      env.CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = 1;
      theme = "dark";
    };
    agents = {
      code = ./agents/code.md;
      documentation = ./agents/documentation.md;
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
    memory.source = ./memory.md;
  };
}
