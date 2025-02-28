{pkgs}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      bash-language-server
      buf
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      lua-language-server
      marksman
      (python3.withPackages (ps:
        with ps; [
          black
          python-lsp-server
          python-lsp-ruff
          python-lsp-black
        ]))
      ruff
      nixd
      prettierd
      rust-analyzer
      clippy
      svls
      texlab
      vhdl-ls
      vscode-extensions.llvm-org.lldb-vscode
      yaml-language-server
    ];
    languages = {
      language-server = {
        pylsp = {
          config = {
            pylsp = {
              plugins = {
                black.enabled = true;
                ruff.enabled = true;
              };
            };
          };
        };
        rust-analyzer = {
          config = {
            check.command = "clippy";
          };
        };
      };
      language = [
        {
          name = "markdown";
          formatter = {
            command = "prettierd";
            args = ["--parser" "markdown"];
          };
        }
      ];
    };
    settings = {
      theme = "tokyonight";
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
        inline-diagnostics = {
          cursor-line = "warning";
        };
        line-number = "relative";
        scrolloff = 8;
        soft-wrap.enable = true;
        statusline = {
          left = ["mode" "spacer" "version-control"];
          center = ["file-name"];
          right = ["diagnostics" "file-modification-indicator" "read-only-indicator" "file-type" "separator" "position" "total-line-numbers"];
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
