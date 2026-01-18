{ llm-agents, ... }:
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    package = llm-agents.claude-code;
    settings = {
      attribution = {
        commit = "";
        pr = "";
      };
      env = {
        CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR = "1";
        USE_BUILTIN_RIPGREP = "0";
      };
      permissions.allow = [
        # Git (read-only + local operations)
        "Bash(git add:*)"
        "Bash(git branch:*)"
        "Bash(git commit:*)"
        "Bash(git diff:*)"
        "Bash(git log:*)"
        "Bash(git show:*)"
        "Bash(git show-ref:*)"
        "Bash(git status:*)"
        # GitHub CLI (read-only)
        "Bash(gh issue list:*)"
        "Bash(gh issue view:*)"
        "Bash(gh pr checks:*)"
        "Bash(gh pr diff:*)"
        "Bash(gh pr list:*)"
        "Bash(gh pr view:*)"
        # Jujutsu (read-only + local operations)
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
      showTurnDuration = false;
      spinnerTipsEnabled = false;
      statusLine = {
        type = "command";
        command = ''cat | jq -r '"[\(.model.display_name)] \(.workspace.current_dir | split("/") | .[-1]) | \(.context_window.used_percentage | floor)% | +\(.cost.total_lines_added // 0)/-\(.cost.total_lines_removed // 0)"' '';
        padding = 0;
      };
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
