{ pkgs, ... }:
{
  programs =
    if pkgs.hostPlatform.isLinux then
      {
        zen-browser = {
          enable = true;
          nativeMessagingHosts = [ pkgs.firefoxpwa ];
        };
      }
    else
      { };
}
