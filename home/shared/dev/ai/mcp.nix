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
      export ${context7-api-key-env}=$(${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${
        config.sops.secrets."api-keys/context7".path
      })
    '';
    fish.interactiveShellInit = ''
      set -gx ${context7-api-key-env} (${lib.getExe' pkgs.uutils-coreutils-noprefix "cat"} ${
        config.sops.secrets."api-keys/openrouter".path
      })
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
      deepwiki = {
        url = "https://mcp.deepwiki.com/mcp";
      };
    };
  };
}
