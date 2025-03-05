{pkgs}: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    enableExtraSocket = true;
    enableSshSupport = true;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
