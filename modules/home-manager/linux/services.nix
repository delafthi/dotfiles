{pkgs ? import <nixpkgs> {}}: {
  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      defaultCacheTtl = 86400;
      defaultCacheTtlSsh = 86400;
      maxCacheTtl = 86400;
      maxCacheTtlSsh = 86400;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    unclutter = {
      enable = true;
      timeout = 10;
    };
  };
}
