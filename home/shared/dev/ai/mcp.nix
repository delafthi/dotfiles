{ lib, pkgs, ... }:
{
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
