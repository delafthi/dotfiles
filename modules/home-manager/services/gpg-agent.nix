{pkgs, ...}: {
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 30;
    defaultCacheTtlSsh = 30;
    enableExtraSocket = true;
    enableSshSupport = true;
    maxCacheTtl = 30;
    maxCacheTtlSsh = 30;
    pinentryPackage =
      if pkgs.hostPlatform.isDarwin
      then pkgs.pinentry_mac
      else if pkgs.hostPlatform.isLinux
      then pkgs.pinentry-gnome3
      else null;
  };
}
