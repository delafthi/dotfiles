{pkgs, ...}: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 30;
    defaultCacheTtlSsh = 30;
    enableExtraSocket = true;
    enableSshSupport = true;
    maxCacheTtl = 30;
    maxCacheTtlSsh = 30;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
