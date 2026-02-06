{
  pkgs,
}:
let
  name = "test-yubico-pam";
  description = "Test Yubico PAM authentication configuration";
  # Login test only works on Linux (pamtester login module)
  # Sudo test works on both platforms
  usage = ''
    Usage: ${name} [OPTIONS] [SERVICES...]

    ${description}

    Verifies that your YubiKey is properly configured for PAM
    authentication using pamtester.

    Options:
      -h, --help     Show this help message and exit
      -v, --verbose  Show detailed output

    Arguments:
      SERVICES       PAM services to test (e.g., sudo, login).
                     Defaults to platform-specific services.

    Platform Behavior:
      Linux:  Tests 'login' and 'sudo' services by default
      Darwin: Tests 'sudo' service only ('login' not available)

    Examples:
      ${name}              # Test default services
      ${name} sudo         # Test only sudo service
      ${name} -v sudo      # Verbose output for sudo
  '';
in
{
  type = "app";
  program = "${
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [ pamtester ];
      text = ''
        show_help() {
          cat <<'EOF'
        ${usage}
        EOF
        }

        VERBOSE=""
        SERVICES=()

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -h|--help)
              show_help
              exit 0
              ;;
            -v|--verbose)
              VERBOSE="1"
              shift
              ;;
            -*)
              echo "Error: Unknown option '$1'" >&2
              echo "Run '${name} --help' for usage information." >&2
              exit 1
              ;;
            *)
              SERVICES+=("$1")
              shift
              ;;
          esac
        done

        # Determine default services based on platform
        if [[ ''${#SERVICES[@]} -eq 0 ]]; then
          ${
            if pkgs.stdenv.hostPlatform.isDarwin then
              ''
                SERVICES=("sudo")
              ''
            else
              ''
                SERVICES=("login" "sudo")
              ''
          }
        fi

        USER="$(whoami)"
        FAILED=0

        echo "Testing Services: ''${SERVICES[*]}"
        echo ""
        echo "Touch your YubiKey when prompted..."
        echo ""

        for service in "''${SERVICES[@]}"; do
          echo -n "Testing $service... "
          if [[ -n "$VERBOSE" ]]; then
            echo ""
            if pamtester -v "$service" "$USER" authenticate; then
              echo "✓ $service: OK"
            else
              echo "✗ $service: FAILED"
              FAILED=1
            fi
          else
            if result=$(pamtester "$service" "$USER" authenticate 2>&1); then
              echo "✓ OK"
            else
              echo "✗ FAILED"
              echo "  ''${result#pamtester: }"
              FAILED=1
            fi
          fi
        done

        echo ""
        if [[ $FAILED -eq 0 ]]; then
          echo "All tests passed!"
          exit 0
        else
          echo "Some tests failed. Check your PAM configuration."
          exit 1
        fi
      '';
    }
  }/bin/${name}";
  meta = {
    inherit description;
    mainProgram = name;
  };
}
