{
  pkgs,
  user,
  ...
}:
{
  home = {
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";
    preferXdgDirectories = true;
  };
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        DEVELOPER = "$HOME/Developer";
        MOVIES = "$HOME/Movies";
      };
      videos = "$HOME/Movies";
    };
  };
}
