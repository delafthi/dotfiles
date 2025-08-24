{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    literalExpression
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

    servers = mkOption {
      inherit (jsonFormat) type;
      default = { };
      example = literalExpression ''
        everything = {
          command = "npx",
          args = [
            "-y"
            "@modelcontextprotocol/server-everything"
          ];
        };
      '';
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/opencode/config.json`.
        See <https://opencode.ai/docs/config/> for the documentation.
      '';
    };
  };

  config = mkIf cfg.enable {
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
