#!/usr/bin/env python3
"""Update packages that have an updateScript defined."""

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path


def nix_eval(
    attr: str,
    *,
    expr: bool = False,
    apply: str | None = None,
    ifd: bool = False,
    impure: bool = False,
) -> str:
    """Evaluate a nix attribute or expression, returning raw string output."""
    cmd = ["nix", "eval", "--raw"]
    if expr:
        cmd += ["--expr", attr]
    else:
        cmd.append(attr)
    if apply:
        cmd += ["--apply", apply]
    if ifd:
        cmd += ["--allow-import-from-derivation"]
    if impure:
        cmd += ["--impure"]
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(result.stderr, file=sys.stderr, end="")
        raise subprocess.CalledProcessError(result.returncode, cmd)
    return result.stdout.strip()


def git(*args: str, check: bool = True) -> subprocess.CompletedProcess:
    return subprocess.run(["git"] + list(args), check=check)


def git_output(*args: str) -> str:
    return subprocess.check_output(["git"] + list(args), text=True)


def discover_packages(system: str) -> list[str]:
    """Return one representative attr per package.nix that defines updateScript.

    Uses file-based discovery so that packages sharing a package.nix (e.g. all
    claudePlugins-claude-code-* attrs) are represented by a single attr, avoiding
    redundant updates and duplicate PRs.
    """
    raw = nix_eval(
        f".#packages.{system}",
        apply='pkgs: builtins.concatStringsSep "\n" (builtins.attrNames pkgs)',
        ifd=True,
    )
    all_attrs = raw.splitlines()

    packages = []
    for pkg_file in sorted(Path("packages").rglob("package.nix")):
        if "updateScript" not in pkg_file.read_text():
            continue
        # packages/claudePlugins/claude-code/package.nix
        #   -> parts[1:-1] = ["claudePlugins", "claude-code"]
        #   -> prefix       = "claudePlugins-claude-code"
        prefix = "-".join(pkg_file.parts[1:-1])
        for attr in all_attrs:
            if attr == prefix or attr.startswith(prefix + "-"):
                packages.append(attr)
                break

    return packages


def parse_version(diff: str, *, removed: bool) -> str:
    """Extract a version string from a unified diff hunk."""
    marker = r"^-" if removed else r"^\+"
    pattern = re.compile(rf"{marker}\s*version\s*=\s*\"([^\"]+)\"")
    for line in diff.splitlines():
        m = pattern.match(line)
        if m:
            return m.group(1)
    return "unknown"


def update_package(attr: str, system: str, *, do_commit: bool) -> bool:
    """Update a single package. Returns True on success."""
    print(f"\n==> Updating {attr}...")

    # nix-update uses nix-instantiate, which copies the repo to the nix store.
    # git's fsmonitor socket (.git/fsmonitor--daemon.ipc) triggers an "unsupported
    # file type" error during that copy. Stopping the daemon removes the socket.
    subprocess.run(
        ["git", "fsmonitor--daemon", "stop"], check=False, capture_output=True
    )

    result = subprocess.run(
        [
            "nix-update",
            "--build",
            "--flake",
            "--quiet",
            attr,
        ]
    )

    git("add", "-A")
    no_changes = (
        git("diff", "--staged", "--quiet", "--", "packages/", check=False).returncode
        == 0
    )

    if result.returncode != 0 and no_changes:
        print(f"Error: nix-update failed for {attr}", file=sys.stderr)
        return False

    if no_changes:
        print(f"{attr}: already up to date")
        git("restore", "--staged", ".", check=False)
        return True

    if do_commit:
        git("add", "-A")
        diff = git_output("diff", "--staged", "--", "packages/")
        old_ver = parse_version(diff, removed=True)
        new_ver = parse_version(diff, removed=False)
        git("commit", "-m", f"chore(packages/{attr}): {old_ver} -> {new_ver}")

    return True


def main() -> None:
    parser = argparse.ArgumentParser(
        prog="update-packages",
        description="Update packages that have an updateScript defined.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=(
            "examples:\n"
            "  nix run .#update-packages                           # update all\n"
            "  nix run .#update-packages -- --commit               # update all, commit each\n"
            "  nix run .#update-packages -- claudePlugins-caveman  # update one package\n"
            "  nix run .#update-packages -- --list                 # print packages as JSON\n"
        ),
    )
    parser.add_argument(
        "packages",
        nargs="*",
        metavar="PACKAGE",
        help="package attribute names to update (default: all)",
    )
    parser.add_argument(
        "--commit",
        action="store_true",
        help="create a git commit for each updated package",
    )
    parser.add_argument(
        "--keep-going",
        action="store_true",
        help="continue past failures instead of stopping",
    )
    parser.add_argument(
        "--list",
        action="store_true",
        help="print discovered packages as a JSON array and exit",
    )
    args = parser.parse_args()

    system = nix_eval("builtins.currentSystem", expr=True, impure=True)

    if args.list:
        print(json.dumps(discover_packages(system)))
        return

    packages: list[str] = args.packages
    if not packages:
        print(f"Discovering packages with updateScript for system: {system}")
        packages = discover_packages(system)
        print(f"Found {len(packages)} package(s): {' '.join(packages)}")

    failed: list[str] = []
    for pkg in packages:
        if not update_package(pkg, system, do_commit=args.commit):
            failed.append(pkg)
            if not args.keep_going:
                print(
                    "\nAborting. Use --keep-going to continue past failures.",
                    file=sys.stderr,
                )
                sys.exit(1)

    if failed:
        print(
            f"\nFailed to update {len(failed)} package(s): {' '.join(failed)}",
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
