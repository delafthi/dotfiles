{
  pkgs,
}:
let
  name = "apply";
  description = "Apply the nix configuration for the current host";
  usage = ''
    Usage: ${name} [OPTIONS] [HOSTNAME]

    ${description}

    Options:
      -h, --help     Show this help message and exit

    Arguments:
      HOSTNAME       The hostname of the configuration to apply.
                     Defaults to the current hostname.

    Environment Variables:
      EXTRA_ARGS     Additional arguments passed to the rebuild command
                     (darwin-rebuild or nixos-rebuild).

    Examples:
      nix run .#${name}                     # Apply configuration
      nix run .#${name} -- my-machine       # Apply a specific host configuration
      nix run .#${name} -- -- --show-trace  # Pass --show-trace to rebuild
  '';
in
{
  type = "app";
  program = "${
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [ hostname ];
      text = ''
        show_help() {
          cat <<'EOF'
        ${usage}
        EOF
        }

        HOSTNAME="''${HOSTNAME:-}"
        EXTRA_ARGS="''${EXTRA_ARGS:-}"

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -h|--help)
              show_help
              exit 0
              ;;
            --)
              shift
              EXTRA_ARGS="''${EXTRA_ARGS:+$EXTRA_ARGS }$*"
              break
              ;;
            -*)
              echo "Error: Unknown option '$1'" >&2
              echo "Run '${name} --help' for usage information." >&2
              exit 1
              ;;
            *)
              if [[ -z "$HOSTNAME" ]]; then
                HOSTNAME="$1"
              else
                echo "Error: Unexpected argument '$1'" >&2
                echo "Run '${name} --help' for usage information." >&2
                exit 1
              fi
              shift
              ;;
          esac
        done

        if [[ -z "$HOSTNAME" ]]; then
          HOSTNAME="$(hostname -s)"
        fi

        ${
          if pkgs.stdenv.hostPlatform.isDarwin then
            ''
              CMD="sudo darwin-rebuild"
            ''
          else
            ''
              CMD="sudo nixos-rebuild"
            ''
        }

        # shellcheck disable=SC2086
        $CMD switch --flake ".#$HOSTNAME" $EXTRA_ARGS
      '';
    }
  }/bin/${name}";
  meta = {
    inherit description;
    mainProgram = name;
  };
}
