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
      zoxide
    ];
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
      preview = {
        max_width = 1000;
        max_height = 1000;
      };
    };
    shellWrapperName = "yd";
  };
}
