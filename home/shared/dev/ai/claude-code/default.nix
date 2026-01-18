{ llm-agents, ... }:
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    package = llm-agents.claude-code;
    settings = {
      env.CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = 1;
      theme = "dark";
      permissions.allow = [
        # Git
        "Bash(git add:*)"
        "Bash(git branch:*)"
        "Bash(git commit:*)"
        "Bash(git diff:*)"
        "Bash(git log:*)"
        "Bash(git push:*)"
        "Bash(git show:*)"
        "Bash(git show-ref:*)"
        "Bash(git status:*)"
        # GitHub CLI
        "Bash(gh issue:*)"
        "Bash(gh pr:*)"
        # Jujutsu
        "Bash(jj bookmark:*)"
        "Bash(jj describe:*)"
        "Bash(jj diff:*)"
        "Bash(jj log:*)"
        "Bash(jj new:*)"
        "Bash(jj show:*)"
        "Bash(jj status:*)"
        # Just
        "Bash(just:*)"
        # Mise
        "Bash(mise:*)"
        # Nix
        "Bash(nix build:*)"
        "Bash(nix flake check:*)"
        "Bash(nix fmt:*)"
        # Test
        "Bash(test -d:*)"
        "Bash(test -f:*)"
      ];
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
