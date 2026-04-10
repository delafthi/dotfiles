{ pkgs, ... }:
let
  anthropics-claude-code = pkgs.fetchFromGitHub {
    owner = "anthropics";
    repo = "claude-code";
    rev = "22fdf68049e8c24e5a36087bb742857d3d5e407d";
    sha256 = "04vnvgm8qabidxdqmiz0cg4z3dyrj7wnsqpgqfipx1mp7bhyipyx";
  };
in
{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    plugins = [
      (pkgs.fetchFromGitHub {
        owner = "JuliusBrussee";
        repo = "caveman";
        rev = "26c25e39b3aee469dbb017427ab55ee1d32de1a8";
        sha256 = "0kgajb0l6ppx5rqy32j9g1ij95wylhznzjgq56salq65hg3mm8sy";
      })
      "${anthropics-claude-code}/plugins/code-review"
      "${anthropics-claude-code}/plugins/pr-review-toolkit"
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
        command = "${pkgs.jq}/bin/jq -r '(.model.display_name) + \" | \" + ((.context_window.total_input_tokens // 0 | tostring) + \"/\" + (.context_window.context_window_size // 0 | tostring) + \" tok\") + \" | $\" + (.cost.total_cost_usd // 0 | . * 1000 | round / 1000 | tostring)'";
      };
    };
    memory.text = ''
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
