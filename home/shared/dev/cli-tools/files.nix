{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hexyl
      pandoc
      tesseract
    ];
    sessionVariables = {
      MANPAGER = "sh -c 'sed -u -e \\\"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\\\" | bat -p -lman'";
      PAGER = "bat -p";
    };
  };
  programs.bat = {
    enable = true;
    config = {
      italic-text = "always";
    };
  };
}
