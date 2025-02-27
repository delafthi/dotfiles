{pkgs}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      buf
      clang-tools
      cmake-language-server
      dockerfile-language-server-nodejs
      lua-language-server
      marksman
      nil
      (python3.withPackages (ps:
        with ps; [
          black
          python-lsp-server
          python-lsp-ruff
          python-lsp-black
        ]))
      ruff
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
        file-picker.hidden = false;
        indent-guides.render = true;
        line-number = "relative";
        lsp.display-inlay-hints = true;
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
