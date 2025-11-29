{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      vscode-extensions.llvm-org.lldb-vscode
      shfmt
      bash-language-server
      fish-lsp
      jq-lsp
      just-lsp
      marksman
      yaml-language-server
    ];
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
