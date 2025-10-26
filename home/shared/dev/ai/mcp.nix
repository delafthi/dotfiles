{
  config,
  lib,
  pkgs,
  ...
}:
let
  context7-api-key-env = "CONTEXT7_API_KEY";
in
{
  programs = {
    bash.initExtra = ''
      export ${context7-api-key-env}=$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.context7-api-key.path})
    '';
    fish.interactiveShellInit = ''
      set -gx ${context7-api-key-env} (${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.context7-api-key.path})
    '';
  };
  programs.mcp = {
    enable = true;
    servers = {
      context7 = {
        command = "${lib.getExe' pkgs.bun "bunx"}";
        args = [
          "-y"
          "@upstash/context7-mcp"
        ];
      };
      fetch = {
        command = "${lib.getExe' pkgs.uv "uvx"}";
        args = [
          "mcp-server-fetch"
        ];
      };
      filesystem = {
        command = "${lib.getExe' pkgs.bun "bunx"}";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "${config.home.homeDirectory}/Developer"
        ];
      };
      git = {
        command = "${lib.getExe' pkgs.uv "uvx"}";
        args = [
          "mcp-server-git"
        ];
      };
      memory = {
        command = "${lib.getExe' pkgs.bun "bunx"}";
        args = [
          "-y"
          "@modelcontextprotocol/server-memory"
        ];
      };
      sequential-thinking = {
        command = "${lib.getExe' pkgs.bun "bunx"}";
        args = [
          "-y"
          "@modelcontextprotocol/server-sequential-thinking"
        ];
      };
    };
  };
}
