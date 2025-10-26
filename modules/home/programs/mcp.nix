{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    literalExpression
    mkDefault
    mkEnableOption
    mkIf
    mkOption
    ;

  cfg = config.programs.mcp;

  jsonFormat = pkgs.formats.json { };
in
{
  meta.maintainers = with lib.maintainers; [ delafthi ];

  options.programs.mcp = {
    enable = mkEnableOption "mcp";

    enableOpencodeIntegration = mkOption {
      type = lib.types.bool;
      default = true;
      description = ''
        Whether to integrate MCP servers with OpenCode by translating
        the configuration to {option}`config.opencode.settings.mcp`.

        This is enabled by default. Disable if you only want to generate
        the MCP config file without OpenCode integration.

        Note: Settings defined in {option}`programs.mcp.servers` are merged
        with {option}`programs.opencode.settings.mcp`, with direct OpenCode
        settings taking precedence over generated ones.
      '';
    };

    servers = mkOption {
      inherit (jsonFormat) type;
      default = { };
      example = literalExpression ''
        {
          everything = {
            command = "npx";
            args = [
              "-y"
              "@modelcontextprotocol/server-everything"
            ];
          };
          context7 = {
            serverUrl = "https://mcp.context7.com/mcp";
            headers = {
              CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
            };
          };
        }
      '';
      description = ''
        MCP server configurations. Each server can be either:

        - Local: Uses {option}`command` and {option}`args` to spawn a local MCP server
        - Remote: Uses {option}`serverUrl` to connect to a remote MCP server

        Local servers support optional {option}`environment` variables.
        Remote servers support optional {option}`headers`.
        Both types support an optional {option}`disabled` boolean flag.

        Configuration is written to {file}`$XDG_CONFIG_HOME/mcp/mcp.json`
        and translated to {file}`$XDG_CONFIG_HOME/opencode/config.json`.

        See <https://opencode.ai/docs/mcp-servers/> for the documentation.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.opencode.settings.mcp = mkIf (cfg.enableOpencodeIntegration && cfg.servers != { }) (
      lib.attrsets.concatMapAttrs (name: value: {
        ${name} = mkDefault (
          {
            enabled = if (lib.hasAttr "disabled" value) then !value.disabled else true;
          }
          // lib.optionalAttrs (lib.hasAttr "serverUrl" value) (
            {
              type = "remote";
              url = value.serverUrl;
            }
            // lib.optionalAttrs (lib.hasAttr "headers" value) { inherit (value) headers; }
          )
          // lib.optionalAttrs (lib.hasAttr "command" value) (
            {
              type = "local";
              command = [ value.command ] ++ value.args;
            }
            // lib.optionalAttrs (lib.hasAttr "environment" value) {
              env = value.environment;
            }
          )
        );
      }) cfg.servers
    );
    xdg.configFile = mkIf (cfg.servers != { }) (
      let
        mcp-config = {
          mcpServers = cfg.servers;
        };
      in
      {
        "mcp/mcp.json".source = jsonFormat.generate "mcp.json" mcp-config;
      }
    );
  };
}
