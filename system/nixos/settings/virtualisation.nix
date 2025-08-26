{
  virtualisation = {
    libvirtd.enable = true;
    lxd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
