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
    rules = ''
      # Global Agent Guidelines

      ## Version Control System Detection

      Detect the version control system before performing any VCS operations.

      ### Detection
      - Check for `.jj/` directory in repository root → use **jujutsu**
      - Otherwise, check for `.git/` directory → use **git**

      ### Detection Command
      ```bash
      test -d .jj && echo "jujutsu" || echo "git"
      ```

      ### Usage Rules
      When `.jj/` is detected, use jujutsu commands:
      - `jj status` (not `git status`)
      - `jj diff` (not `git diff`)
      - `jj describe -m "message"` (not `git commit -m`)
      - `jj new` (create new change, not `git commit`)
      - `jj branch` (not `git branch`)
      - `jj log` (not `git log`)

      **Important**: NEVER mix git and jujutsu commands in the same repository.

      ## Build System Detection

      Detect the build system before running build, format, or check operations.

      ### Detection Priority
      1. **Nix Flakes**: Check for `flake.nix`
      2. **Just**: Check for `justfile` or `Justfile`
      3. **Language-specific**: Check for `package.json`, `Cargo.toml`, `pyproject.toml`, `go.mod`, etc.

      ### Detection Command
      ```bash
      if [ -f flake.nix ]; then
        echo "nix"
      elif [ -f justfile ] || [ -f Justfile ]; then
        echo "just"
      else
        echo "language-specific"
      fi
      ```

      ### Priority Rules
      1. **Nix takes precedence** when `flake.nix` exists:
         - Format: `nix fmt` (prefer over `just fmt`)
         - Check: `nix flake check` (prefer over `just check`)
         - Build: `nix build` (prefer over `just build`)
         - Update: `nix flake update` (prefer over `just update`)

      2. **Just as secondary** when no `flake.nix`:
         - List tasks: `just --list`
         - Use for project-specific workflows

      3. **Language-specific tools** when neither Nix nor Just exist:
         - npm/pnpm/yarn for `package.json`
         - cargo for `Cargo.toml`
         - go for `go.mod`
         - Check project README/CONTRIBUTING for preferred commands

      ### Best Practices
      - Always detect before assuming tool availability
      - Respect the detected hierarchy
      - When both `flake.nix` and `justfile` exist, prefer Nix commands (just may wrap Nix for convenience)

      ## Personal Preferences

      - **VCS**: Prefer jujutsu when available
      - **Build system**: Prefer Nix for reproducibility
      - **Detection first**: Always verify tool availability before use
    '';
  };
}
