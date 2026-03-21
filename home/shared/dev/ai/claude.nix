{ pkgs, ... }:
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      env = {
        CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";
      };
      feedbackSurveyRate = 0;
      permissions = {
        allow = [
          "Read(**/*)"
          "WebFetch(*)"
          "WebSearch(*)"
        ];
      };
      statusLine = {
        type = "command";
        command = "${pkgs.jq}/bin/jq -r '(.model.display_name) + \" | \" + ((.context_window.total_input_tokens // 0 | tostring) + \"/\" + (.context_window.context_window_size // 0 | tostring) + \" tok\") + \" | $\" + (.cost.total_cost_usd // 0 | . * 1000 | round / 1000 | tostring)'";
      };
    };
    memory.text = ''
      # Global Memory

      ## Version Control
      - This project uses **jujutsu** (`jj`) for version control, not git.
        Prefer `jj` commands over `git` equivalents.

      ## Style
      - Keep responses concise and direct.
      - No emojis unless explicitly requested.
    '';
  };
}
