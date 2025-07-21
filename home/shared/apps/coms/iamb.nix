{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.programs.iamb;
  tomlFormat = pkgs.formats.toml { };
in
{
  programs.iamb = {
    enable = true;
    settings = {
      profiles.user.user_id = "@delafthi:matrix.org";
      layout.style = "restore";
      settings = {
        notifications.enabled = true;
        image_preview.protocol = {
          type = "kitty";
          size = {
            height = 10;
            width = 66;
          };
        };
      };
    };
  };
  # The config is written to XDG_CONFIG_HOME. However, iamb looks in
  # ~/Library/Application Support. So also write a config file there.
  home.file."Library/Application Support/iamb/config.toml" =
    lib.mkIf (cfg.settings != { } && pkgs.stdenv.hostPlatform.isDarwin)
      {
        source = tomlFormat.generate "config.toml" cfg.settings;
      };
}
