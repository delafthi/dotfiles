{
  config,
  lib,
  pkgs,
  ...
}:
{
  home = {
    packages = with pkgs; [
      fd
      ripgrep
      sd
    ];
    sessionVariables = {
      # Required on macOS
      EZA_CONFIG_DIR = "$XDG_CONFIG_HOME/eza";
      LS_COLORS = "$(${lib.getExe pkgs.vivid} generate catppuccin-${config.catppuccin.flavor})";
    };
    shellAliases.cd = "z";
  };
  programs = {
    eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
      ];
      git = true;
      icons = "auto";
    };
    fzf = {
      enable = true;
      changeDirWidgetCommand = "fd --type d --hidden --strip-cwd-prefix --exclude .git";
      changeDirWidgetOptions = [
        "--preview= '${lib.getExe pkgs.eza} --tree --color=always {} | head -200'"
      ];
      defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";
      defaultOptions = [ "--layout reverse" ];
      fileWidgetCommand = "fd --type f --hidden --strip-cwd-prefix --exclude .git";
      fileWidgetOptions = [
        "--preview 'bat -n --color=always --line-range :500 {}'"
      ];
    };
    zoxide.enable = true;
  };
}
