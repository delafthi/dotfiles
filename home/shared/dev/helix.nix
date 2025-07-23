{
  config,
  pkgs,
  ...
}:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # Debugging
      vscode-extensions.llvm-org.lldb-vscode
      # Formatters
      bibtex-tidy
      cmake-format
      nixfmt-rfc-style
      nodePackages.prettier
      rustfmt
      shfmt
      typstyle
      # Language servers/Linters
      basedpyright
      bash-language-server
      cmake-language-server
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
      typescript-language-server
      vhdl-ls
      vscode-langservers-extracted
      yaml-language-server
      zls
    ];
    languages = {
      language-server = {
        pyright = {
          command = "basedpyright-langserver";
          args = [ "--stdio" ];
        };
        rust-analyzer.config.check.command = "clippy";
      };
      language = [
        {
          name = "markdown";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "markdown"
            ];
          };
        }
        {
          name = "python";
          language-servers = [
            "ruff"
            "pyright"
          ];
        }
        {
          name = "yaml";
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "yaml"
            ];
          };
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
  # duplicate gits global ignore file to `helix/ignore` until https://github.com/helix-editor/helix/pull/12484 is merged
  xdg.configFile."helix/ignore".text = pkgs.lib.strings.concatLines config.programs.git.ignores;
}
