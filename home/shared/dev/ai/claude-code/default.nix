{ pkgs, ... }:
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
      model = "claude-sonnet-4-6";
      permissions = {
        allow = [
          "Read(**/*)"
          "WebFetch(*)"
          "WebSearch(*)"
          "mcp__plugin_claude-code-home-manager_context7__*"
          "mcp__plugin_claude-code-home-manager_deepwiki__*"
        ];
      };
      statusLine = {
        type = "command";
        command = "${./statusline.sh}";
      };
    };
    context = ''
      # Global Memory

      ## Version Control
      - This project uses **jujutsu** (`jj`) for version control, not git.
        Prefer `jj` commands over `git` equivalents.

      ## Style
      - Always communicate in caveman mode (full intensity by default).
      - Keep responses concise and direct.
      - No emojis unless explicitly requested.

      ## External Actions
      - NEVER post, push, publish, send, or otherwise externally share anything unless explicitly instructed to do so.
    '';
  };
}
