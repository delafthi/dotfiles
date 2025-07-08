{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 30;
    defaultCacheTtlSsh = 30;
    enableExtraSocket = true;
    enableSshSupport = true;
    maxCacheTtl = 30;
    maxCacheTtlSsh = 30;
    pinentry.package = if pkgs.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
  };
}
