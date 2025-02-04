{ lib
, tokyonight
}: {
  programs.yazi = {
    enable = true;
    settings = {
      manager.showhidden = true;
      sort_dir_fist = true;
    };
    shellWrapperName = "y";
    theme = lib.importTOML "${tokyonight}/extras/yazi/tokyonight_night.toml";
  };
}
