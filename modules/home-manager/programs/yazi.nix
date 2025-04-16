{
  lib,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      fd
      ffmpeg
      fzf
      imagemagick
      jq
      p7zip
      poppler
      ripgrep
      zoxide
    ];
    shellAliases = {
      y = "yazi";
    };
  };
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [2 4 3];
        sort_dir_fist = true;
        showhidden = true;
      };
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
    shellWrapperName = "yd";
  };
}
