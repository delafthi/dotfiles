{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
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
