{
  services.espanso = {
    enable = true;
    configs = {
      default = {
        search_shortcut = "CTRL+CMD+I";
        show_notifications = false;
      };
    };
    matches = {
      global_vars = {
        global_vars = [
        ];
      };
      # Disables automatic generation of base.yaml
      base = {
        matches = [ ];
      };
      direnv = {
        matches = [
          {
            trigger = ":.envrc";
            replace = ''
              if ! has nix; then
                echo -e "\033[0;31mNix is not installed. Please install Nix to use flakes."
                exit 1
              fi

              use flake
            '';
          }
        ];
      };
      editorconfig = {
        matches = [
          {
            trigger = ":.editorconfig";
            replace = ''
              root = true

              [*]
              charset = utf-8
              end_of_line = lf
              trim_trailing_whitespace = true
              indent_style = space
              indent_size = 2
              insert_final_newline = true

              [{Justfile,Makefile}]
              indent_style = tab
            '';
          }
        ];
      };
      nix = {
        matches = [
          {
            trigger = ":default.nix";
            replace = ''
              (import (
                let
                  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
                  nodeName = lock.nodes.root.inputs.flake-compat;
                in
                fetchTarball {
                  url =
                    lock.nodes.''${nodeName}.locked.url
                      or "https://github.com/edolstra/flake-compat/archive/''${lock.nodes.''${nodeName}.locked.rev}.tar.gz";
                  sha256 = lock.nodes.''${nodeName}.locked.narHash;
                }
              ) { src = ./.; }).defaultNix
            '';
          }
          {
            trigger = '':flake.nix'';
            replace = ''
              {
                description = "{{prompt.description}}";
                inputs = {
                  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
                  flake-compat.url = "https://flakehub.com/f/edolstra/flake-compat/1.tar.gz";
                  treefmt-nix.url = "github:numtide/treefmt-nix";
                };

                outputs =
                  inputs@{ flake-parts, ... }:
                  flake-parts.lib.mkFlake { inherit inputs; } {
                    imports = [ inputs.treefmt-nix.flakeModule ];
                    systems = [
                      "aarch64-linux"
                      "x86_64-linux"
                      "aarch64-darwin"
                      "x86_64-darwin"
                    ];
                    perSystem =
                      { pkgs, ... }:
                      {
                        packages = {
                          default = pkgs.callPackage ./nix/{{prompt.name}}.nix;
                        };
                        devShells = {
                          default = pkgs.mkShell {
                            name = "{{prompt.name}}";
                            packages = [ ];
                          };
                        };
                        treefmt = {
                          projectRootFile = "flake.nix";
                          programs.nixfmt.enable = true;
                        };
                      };
                  };
              }
            '';
            vars = [
              {
                name = "prompt";
                type = "form";
                params = {
                  layout = ''
                    name = [[name]]
                    description = [[description]]
                  '';
                };
              }
            ];
          }
          {
            trigger = '':package.nix'';
            replace = ''
              {
                stdenv,
              }:
              stdenv.mkDerivation {
                pname = "{{prompt.name}}";
                version = "{{prompt.version}}";

                buildInputs = [];

                nativeBuildInputs = [];

                meta = {
                  description = "{{prompt.description}}";
                };
              }
            '';
            vars = [
              {
                name = "prompt";
                type = "form";
                params = {
                  layout = ''
                    name = [[name]]
                    version = [[version]]
                    description = [[description]]
                  '';
                };
              }
            ];
          }
          {
            trigger = ":shell.nix";
            replace = ''
              (import (
                let
                  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
                  nodeName = lock.nodes.root.inputs.flake-compat;
                in
                fetchTarball {
                  url =
                    lock.nodes.''${nodeName}.locked.url
                      or "https://github.com/edolstra/flake-compat/archive/''${lock.nodes.''${nodeName}.locked.rev}.tar.gz";
                  sha256 = lock.nodes.''${nodeName}.locked.narHash;
                }
              ) { src = ./.; }).shellNix
            '';
          }
          {
            trigger = ":treefmt.nix";
            replace = ''
              {
                projectRootFile = "flake.nix";
                programs = {
                  nixfmt.enable = true;
                };
                settings.global.excludes = [
                  ".cache/**"
                  ".direnv/**"
                  ".env/**"
                  ".git/**"
                  ".jj/**"
                  ".venv/**"
                  ".svn/**"
                  "build/**"
                  "result/**"
                ];
              }
            '';
          }
        ];
      };
    };
  };
}
