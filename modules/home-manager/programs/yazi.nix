{ lib
, tokyonight
}: {
  programs.yazi = {
    enable = true;
    settings = {
      manager = {
        ratio = [ 2 4 3 ];
        sort_dir_fist = true;
        showhidden = true;
      };
    };
    shellWrapperName = "y";
    theme = lib.importTOML "${tokyonight}/extras/yazi/tokyonight_night.toml";
  };
}
