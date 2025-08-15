{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.sessionVariables = {
    GITHUB_PERSONAL_ACCESS_TOKEN = ''$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${config.sops.secrets.github-personal-access-token.path})'';
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
      github = {
        command = "${lib.getExe pkgs.podman}";
        args = [
          "run"
          "-i"
          "--rm"
          "-e"
          "GITHUB_PERSONAL_ACCESS_TOKEN"
          "ghcr.io/github/github-mcp-server"
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
