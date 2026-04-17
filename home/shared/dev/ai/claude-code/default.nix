{ pkgs, lib, ... }:
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    plugins = [
      pkgs.claudePlugins.caveman
      pkgs.claudePlugins.claude-code.code-review
      pkgs.claudePlugins.claude-code.pr-review-toolkit
    ];
    settings = {
      env = {
        CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      };
      feedbackSurveyRate = 0;
      hooks = {
        SessionStart = [
          {
            hooks = [
              {
                type = "command";
                command = "${lib.getExe pkgs.nodejs} ${pkgs.claudePlugins.caveman}/hooks/caveman-activate.js";
                timeout = 5;
                statusMessage = "Loading caveman mode...";
              }
            ];
          }
        ];
      };
      model = "opusplan";
      permissions = {
        allow = [
          "Agent(caveman:*)"
          "Agent(code-review:*)"
          "Agent(pr-review-toolkit:*)"
          "Glob(**/*)"
          "Grep(**/*)"
          "mcp__plugin_claude-code-home-manager_context7__*"
          "mcp__plugin_claude-code-home-manager_deepwiki__*"
          "Read(**/*)"
          "Read(/nix/store/**)"
          "Read(/tmp/**)"
          "Skill(caveman:*)"
          "Skill(code-review:*)"
          "Skill(pr-review-toolkit:*)"
          "WebFetch"
          "WebSearch"
        ];
      };
      statusLine = {
        type = "command";
        command = "${./statusline.sh}";
      };
    };
    context = ''
      # Global Guidelines

      ## Version Control
      - Prefer `jj` over `git`. Use `jj` commands by default.
      - Key commands: `jj new` (new change), `jj describe` (set message), `jj squash` (amend into parent), `jj log` (history), `jj diff` (show changes).

      ## External Actions
      - NEVER post, push, publish, send, or otherwise externally share anything unless explicitly instructed to do so.
    '';
  };
}
