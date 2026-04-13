{
  pkgs,
}:
let
  name = "update-packages";
  description = "Update packages that have an updateScript defined";
  usage = ''
    Usage: ${name} [OPTIONS] [PACKAGE...]

    ${description}

    When no PACKAGE is given, all packages with updateScript are discovered
    and updated automatically.

    Options:
      -h, --help     Show this help message and exit
      --commit       Create a git commit for each updated package

    Arguments:
      PACKAGE        One or more package attribute names to update
                     (e.g. claudePlugins-caveman)

    Examples:
      nix run .#${name}                               # Update all packages
      nix run .#${name} -- --commit                   # Update all and commit each
      nix run .#${name} -- claudePlugins-caveman       # Update a single package
      nix run .#${name} -- pkg-a pkg-b --commit       # Update specific packages and commit
  '';
in
{
  type = "app";
  program = "${
    pkgs.writeShellApplication {
      inherit name;
      runtimeInputs = with pkgs; [
        nix-update
        git
      ];
      text = ''
        show_help() {
          cat <<'EOF'
        ${usage}
        EOF
        }

        PACKAGES=()
        DO_COMMIT=0

        while [[ $# -gt 0 ]]; do
          case "$1" in
            -h|--help) show_help; exit 0 ;;
            --commit) DO_COMMIT=1; shift ;;
            -*)
              echo "Error: Unknown option '$1'" >&2
              echo "Run '${name} --help' for usage information." >&2
              exit 1
              ;;
            *) PACKAGES+=("$1"); shift ;;
          esac
        done

        SYSTEM="$(nix eval --impure --raw --expr 'builtins.currentSystem')"

        update_package() {
          local attr="$1" old_version new_version
          echo "Updating ''${attr}..."
          # nix-update uses nix-instantiate which copies the repo dir to the nix store;
          # git's fsmonitor socket (.git/fsmonitor--daemon.ipc) causes an "unsupported
          # file type" error. Stopping the daemon removes the socket; git restarts it.
          # The exit code is ignored because nix-update's post-update diff-URL generation
          # re-evaluates the flake and fails with a stale drv after the hash changes —
          # the actual file update still succeeds.
          git fsmonitor--daemon stop 2>/dev/null || true
          nix-update --flake "$attr" || true
          # Stage immediately so git diff --staged reflects only this package's changes,
          # not accumulated diffs from prior packages that were not committed.
          git add -A
          if git diff --staged --quiet; then
            git restore --staged . 2>/dev/null || true
            return
          fi
          old_version=$(git diff --staged -- packages/ | grep '^-[[:space:]]*version' | grep -oE '"[^"]+"' | tr -d '"' | head -1 || echo "unknown")
          new_version=$(git diff --staged -- packages/ | grep '^+[[:space:]]*version' | grep -oE '"[^"]+"' | tr -d '"' | head -1 || echo "unknown")
          # Realize the updated source in the nix store so that IFD (import-from-derivation)
          # in packages like claudePlugins-claude-code works in subsequent nix-update calls.
          # nix-update only computes the hash; it leaves the source drv unrealized, which
          # causes "path is not valid" errors when evaluating the flake for the next package.
          nix build --no-link --allow-import-from-derivation ".#packages.''${SYSTEM}.''${attr}" 2>/dev/null || true
          if [[ "$DO_COMMIT" -eq 1 ]]; then
            git commit -m "chore(packages/''${attr}): ''${old_version} -> ''${new_version}"
          else
            git restore --staged . 2>/dev/null || true
          fi
        }

        if [[ ''${#PACKAGES[@]} -eq 0 ]]; then
          echo "Discovering packages with updateScript for system: $SYSTEM"

          mapfile -t ALL_ATTRS < <(
            nix eval ".#packages.''${SYSTEM}" \
              --allow-import-from-derivation \
              --apply 'pkgs: builtins.concatStringsSep "\n" (builtins.attrNames pkgs)' \
              --raw 2>/dev/null || true
          )

          # For each package.nix with updateScript, pick the first matching attr
          while IFS= read -r pkg_file; do
            rel="''${pkg_file#packages/}"; rel="''${rel%/package.nix}"; prefix="''${rel//\//-}"
            for attr in "''${ALL_ATTRS[@]}"; do
              if [[ "$attr" == "$prefix" || "$attr" == "''${prefix}-"* ]]; then
                PACKAGES+=("$attr"); break
              fi
            done
          done < <(grep -rl "updateScript" packages/ --include="*.nix")
        fi

        for pkg in "''${PACKAGES[@]}"; do
          update_package "$pkg"
        done
      '';
    }
  }/bin/${name}";
  meta = {
    inherit description;
    mainProgram = name;
  };
}
