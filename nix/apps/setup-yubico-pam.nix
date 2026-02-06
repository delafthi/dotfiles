{
  pkgs,
}:
let
  name = "setup-yubico-pam";
  description = "Setup Yubico PAM authentication by generating u2f_keys";
  # On Darwin: keys must be stored in /etc/Yubico (requires sudo)
  # On Linux: keys are stored in $XDG_CONFIG_HOME/Yubico (user-level)
  usage = ''
    Usage: ${name} [OPTIONS]

    ${description}

    Generates U2F key configuration for PAM authentication using your
    YubiKey.

    Options:
      -h, --help     Show this help message and exit
      -a, --append   Append to existing u2f_keys instead of overwriting
      -n, --dry-run  Show what would be done without making changes

    Platform Behavior:
      Linux:  Keys stored in $XDG_CONFIG_HOME/Yubico/u2f_keys (user-level)
      Darwin: Keys stored in /etc/Yubico/u2f_keys (requires sudo)

    Examples:
      nix run .#${name}               # Generate new u2f_keys file
      nix run .#${name} -- --append   # Add another YubiKey to existing config
      nix run .#${name} -- --dry-run  # Preview what would happen
  '';
in
{
  type = "app";
  program = "${
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [ pam_u2f ];
      text = ''
        show_help() {
          cat <<'EOF'
        ${usage}
        EOF
        }

        APPEND="''${APPEND:-}"
        DRY_RUN="''${DRY_RUN:-}"

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -h|--help)
              show_help
              exit 0
              ;;
            -a|--append)
              APPEND="1"
              shift
              ;;
            -n|--dry-run)
              DRY_RUN="1"
              shift
              ;;
            *)
              echo "Error: Unknown option '$1'" >&2
              echo "Run '${name} --help' for usage information." >&2
              exit 1
              ;;
          esac
        done

        ${
          if pkgs.stdenv.hostPlatform.isDarwin then
            ''
              YUBICO_DIR="''${YUBICO_DIR:-/etc/Yubico}"
              NEED_SUDO="1"
            ''
          else
            ''
              YUBICO_DIR="''${YUBICO_DIR:-''${XDG_CONFIG_HOME:-$HOME/.config}/Yubico}"
              NEED_SUDO=""
            ''
        }

        U2F_KEYS="$YUBICO_DIR/u2f_keys"

        [[ -n "$NEED_SUDO" ]] && echo "Note: This operation requires sudo on Darwin"
        echo ""

        if [[ -n "$DRY_RUN" ]]; then
          if [[ -n "$APPEND" && -f "$U2F_KEYS" ]]; then
            echo "[dry-run] Would append to: $U2F_KEYS"
          else
            echo "[dry-run] Would create: $U2F_KEYS"
          fi
          exit 0
        fi

        echo "Please touch your YubiKey when it blinks..."
        echo ""

        if [[ -n "$NEED_SUDO" ]]; then
          sudo mkdir -p "$YUBICO_DIR"
          if [[ -n "$APPEND" && -f "$U2F_KEYS" ]]; then
            pamu2fcfg | sudo tee -a "$U2F_KEYS" > /dev/null
          else
            pamu2fcfg | sudo tee "$U2F_KEYS" > /dev/null
          fi
          sudo chmod 600 "$U2F_KEYS"
        else
          mkdir -p "$YUBICO_DIR"
          if [[ -n "$APPEND" ]]; then
            pamu2fcfg >> "$U2F_KEYS"
          else
            pamu2fcfg > "$U2F_KEYS"
          fi
          chmod 600 "$U2F_KEYS"
        fi

        echo ""
        echo "✓ Yubico PAM setup complete!"
        echo "  Key stored in: $U2F_KEYS"
      '';
    }
  }/bin/${name}";
  meta = {
    inherit description;
    mainProgram = name;
  };
}
