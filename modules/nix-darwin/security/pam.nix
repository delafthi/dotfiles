{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.security.pam.services.sudo_local;
in
{
  options = {
    security.pam = {
      services.sudo_local = {
        u2fAuth = lib.mkOption {
          default = config.security.pam.u2f.enable;
          defaultText = lib.literalExpression "config.security.pam.u2f.enable";
          type = lib.types.bool;
          description = ''
            If set, users listed in
            {file}`$XDG_CONFIG_HOME/Yubico/u2f_keys` (or
            {file}`$HOME/.config/Yubico/u2f_keys` if XDG variable is
            not set) are able to log in with the associated U2F key. Path can be
            changed using {option}`security.pam.u2f.authFile` option.
          '';
        };
      };
      u2f = {
        enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
          description = ''
            Enables U2F PAM (`pam-u2f`) module.

            If set, users listed in
            {file}`$XDG_CONFIG_HOME/Yubico/u2f_keys` (or
            {file}`$HOME/.config/Yubico/u2f_keys` if XDG variable is
            not set) are able to log in with the associated U2F key. The path can
            be changed using {option}`security.pam.u2f.authFile` option.

            File format is:
            ```
            <username1>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>:...
            <username2>:<KeyHandle1>,<UserKey1>,<CoseType1>,<Options1>:<KeyHandle2>,<UserKey2>,<CoseType2>,<Options2>:...
            ```
            This file can be generated using {command}`pamu2fcfg` command.

            More information can be found [here](https://developers.yubico.com/pam-u2f/).
          '';
        };
        control = lib.mkOption {
          default = "sufficient";
          type = lib.types.enum [
            "required"
            "requisite"
            "sufficient"
            "optional"
          ];
          description = ''
            This option sets pam "control".
            If you want to have multi factor authentication, use "required".
            If you want to use U2F device instead of regular password, use "sufficient".

            Read
            {manpage}`pam.conf(5)`
            for better understanding of this option.
          '';
        };
        settings = lib.mkOption {
          type = lib.types.submodule {
            freeformType =
              with lib.types;
              attrsOf (
                nullOr (oneOf [
                  bool
                  str
                  int
                  pathInStore
                ])
              );
            options = {
              authfile = lib.mkOption {
                default = null;
                type = with lib.types; nullOr path;
                description = ''
                  By default `pam-u2f` module reads the keys from
                  {file}`$XDG_CONFIG_HOME/Yubico/u2f_keys` (or
                  {file}`$HOME/.config/Yubico/u2f_keys` if XDG variable is
                  not set).

                  If you want to change auth file locations or centralize database (for
                  example use {file}`/etc/u2f-mappings`) you can set this
                  option.

                  File format is:
                  `username:first_keyHandle,first_public_key: second_keyHandle,second_public_key`
                  This file can be generated using {command}`pamu2fcfg` command.

                  More information can be found [here](https://developers.yubico.com/pam-u2f/).
                '';
              };

              appid = lib.mkOption {
                default = null;
                type = with lib.types; nullOr str;
                description = ''
                  By default `pam-u2f` module sets the application
                  ID to `pam://$HOSTNAME`.

                  When using {command}`pamu2fcfg`, you can specify your
                  application ID with the `-i` flag.

                  More information can be found [here](https://developers.yubico.com/pam-u2f/Manuals/pam_u2f.8.html)
                '';
              };

              origin = lib.mkOption {
                default = null;
                type = with lib.types; nullOr str;
                description = ''
                  By default `pam-u2f` module sets the origin
                  to `pam://$HOSTNAME`.
                  Setting origin to an host independent value will allow you to
                  reuse credentials across machines

                  When using {command}`pamu2fcfg`, you can specify your
                  application ID with the `-o` flag.

                  More information can be found [here](https://developers.yubico.com/pam-u2f/Manuals/pam_u2f.8.html)
                '';
              };

              debug = lib.mkOption {
                default = false;
                type = lib.types.bool;
                description = ''
                  Debug output to stderr.
                '';
              };

              interactive = lib.mkOption {
                default = false;
                type = lib.types.bool;
                description = ''
                  Set to prompt a message and wait before testing the presence of a U2F device.
                  Recommended if your device doesn’t have a tactile trigger.
                '';
              };

              cue = lib.mkOption {
                default = false;
                type = lib.types.bool;
                description = ''
                  By default `pam-u2f` module does not inform user
                  that he needs to use the u2f device, it just waits without a prompt.

                  If you set this option to `true`,
                  `cue` option is added to `pam-u2f`
                  module and reminder message will be displayed.
                '';
              };
            };
          };
          default = { };
          example = {
            authfile = "/etc/u2f_keys";
            authpending_file = "";
            userpresence = 0;
            pinverification = 1;
          };
          description = ''
            Options to pass to the PAM module.

            Boolean values render just the key if true, and nothing if false.
            Null values are ignored.
            All other values are rendered as key-value pairs.
          '';
        };
      };
    };
  };
  config =
    let
      u2fArgs = lib.concatLists (
        lib.flip lib.mapAttrsToList config.security.pam.u2f.settings (
          name: value:
          if lib.isBool value then
            lib.optional value name
          else
            lib.optional (value != null) "${name}=${toString value}"
        )
      );
    in
    {
      environment.systemPackages = lib.optionals config.security.pam.u2f.enable [ pkgs.pam_u2f ];
      security.pam.services.sudo_local.text = lib.mkForce (
        lib.concatLines (
          (lib.optional cfg.u2fAuth "auth ${config.security.pam.u2f.control} ${pkgs.pam_u2f}/lib/security/pam_u2f.so ${lib.concatStringsSep " " u2fArgs}")
          ++ (lib.optional cfg.reattach "auth optional ${pkgs.pam-reattach}/lib/pam/pam_reattach.so")
          ++ (lib.optional cfg.touchIdAuth "auth sufficient pam_tid.so")
          ++ (lib.optional cfg.watchIdAuth "auth sufficient ${pkgs.pam-watchid}/lib/pam_watchid.so")
        )
      );
    };
}
