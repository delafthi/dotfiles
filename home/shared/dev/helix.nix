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
      basedpyright
      bibtex-tidy
      clippy
      delve
      bash-language-server
      buf
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      gopls
      lua-language-server
      marksman
      nixd
      nodePackages.prettier
      ruff
      rust-analyzer
      swift-format
      texlab
      tinymist
      vhdl-ls
      vscode-extensions.llvm-org.lldb-vscode
      vscode-langservers-extracted
      yaml-language-server
      zig
      zls
    ];
    languages = {
      language-server = {
        nixd.command = "nixd";
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
          name = "nix";
          language-servers = [ "nixd" ];
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
        scrolloff = 8;
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
