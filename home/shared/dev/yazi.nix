{
  pkgs,
  ...
}:
{
  home.shellAliases.y = "yazi";
  programs.yazi = {
    enable = true;
    extraPackages = with pkgs; [
      fd
      ffmpeg
      file
      fzf
      glow
      imagemagick
      jq
      ouch
      p7zip
      poppler
      resvg
      ripgrep
      starship
      zoxide
    ];
    initLua = ''
      require("full-border"):setup()
      require("starship"):setup()
    '';
    keymap = {
      mgr.prepend_keymap = [
        {
          desc = "Smart filter";
          on = [ "F" ];
          run = "plugin smart-filter";
        }
        {
          desc = "Jump to character";
          on = [ "f" ];
          run = "plugin jump-to-char";
        }
        {
          desc = "Enter the child directory, or open the file";
          on = [ "l" ];
          run = "plugin smart-enter";
        }
        {
          desc = "Open the mount manager";
          on = [ "M" ];
          run = "plugin mount";
        }
        {
          desc = "Paste into the hovered directory or CWD";
          on = [ "p" ];
          run = "plugin smart-paste";
        }
        {
          desc = "Diff the selected file with the hovered file";
          on = [ "<C-d>" ];
          run = "plugin diff";
        }
        {
          desc = "Maximize or restore the preview pane";
          on = [ "<C-f>" ];
          run = "plugin toggle-pane max-preview";
        }
        {
          desc = "Toggle the preview pane";
          on = [ "<C-p>" ];
          run = "plugin toggle-pane min-preview";
        }
        {
          desc = "Open $SHELL in current directory";
          on = [ "<C-s>" ];
          run = "shell \"$SHELL\" --block";
        }
      ];
    };
    plugins = {
      inherit (pkgs.yaziPlugins) diff;
      inherit (pkgs.yaziPlugins) full-border;
      inherit (pkgs.yaziPlugins) jump-to-char;
      inherit (pkgs.yaziPlugins) mount;
      inherit (pkgs.yaziPlugins) ouch;
      inherit (pkgs.yaziPlugins) smart-enter;
      inherit (pkgs.yaziPlugins) smart-filter;
      inherit (pkgs.yaziPlugins) smart-paste;
      inherit (pkgs.yaziPlugins) starship;
      inherit (pkgs.yaziPlugins) toggle-pane;
    };
    settings = {
      mgr = {
        ratio = [
          2
          4
          3
        ];
        sort_dir_fist = true;
        show_hidden = true;
      };
      plugin.prepend_previewers = [
        {
          mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
          run = "ouch";
        }
      ];
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
    shellWrapperName = "yd";
  };
}
