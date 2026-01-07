{ pkgs, ... }:
{
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 30;
    enableExtraSocket = true;
    maxCacheTtl = 30;
    maxCacheTtlSsh = 30;
    pinentry.package =
      if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
  };
}
