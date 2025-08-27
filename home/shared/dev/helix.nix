{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Debugging
      vscode-extensions.llvm-org.lldb-vscode
      # Formatters
      bibtex-tidy
      biome
      cmake-format
      nixfmt-rfc-style
      rustfmt
      shfmt
      swift-format
      typstyle
      # Language servers/Linters
      bash-language-server
      # cmake-language-server
      dockerfile-language-server-nodejs
      fish-lsp
      gopls
      golangci-lint-langserver
      golangci-lint
      just-lsp
      lua-language-server
      marksman
      nixd
      ruff
      rust-analyzer
      clippy
      tinymist
      ty
      typescript-language-server
      vhdl-ls
      vscode-langservers-extracted
      yaml-language-server
      zls
    ];
    languages = {
      language-server = {
        biome = {
          command = "biome";
          args = [ "lsp-proxy" ];
        };
        rust-analyzer.config.check.command = "clippy";
      };
      language = [
        {
          name = "javascript";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
        }
        {
          name = "typescript";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
        }
        {
          name = "tsx";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
        }
        {
          name = "jsx";
          auto-format = true;
          language-servers = [
            {
              name = "typescript-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
        }
        {
          name = "json";
          auto-format = true;
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
        }
      ];
    };
    settings = {
      editor = {
        bufferline = "multiple";
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        end-of-line-diagnostics = "hint";
        file-picker.hidden = false;
        indent-guides.render = true;
        inline-diagnostics.cursor-line = "warning";
        line-number = "relative";
        soft-wrap.enable = true;
        statusline = {
          left = [
            "mode"
            "spacer"
            "version-control"
          ];
          center = [ "file-name" ];
          right = [
            "diagnostics"
            "file-modification-indicator"
            "read-only-indicator"
            "file-type"
            "separator"
            "primary-selection-length"
            "position"
            "total-line-numbers"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };
      };
      keys.normal = {
        "C-h" = "jump_view_left";
        "C-j" = "jump_view_down";
        "C-k" = "jump_view_up";
        "C-l" = "jump_view_right";
      };
    };
  };
}
