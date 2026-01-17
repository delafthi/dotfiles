{
  config,
  lib,
  llm-agents,
  ...
}:
let
  transformMcpServer =
    name: server:
    let
      # Remove the disabled field from the server config
      cleanServer = lib.filterAttrs (n: _v: n != "disabled") server;
    in
    {
      inherit name;
      value = {
        enabled = !(server.disabled or false);
      }
      // (
        if server ? url then
          {
            type = "http";
          }
          // cleanServer
        else if server ? command then
          {
            type = "stdio";
          }
          // cleanServer
        else
          { }
      );
    };

in
{
  programs.claude-code = {
    enable = true;
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
    mcpServers = lib.listToAttrs (lib.mapAttrsToList transformMcpServer config.programs.mcp.servers);
    memory.source = ./memory.md;
  };
}
