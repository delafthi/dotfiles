{
  networking = {
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [
        22
        80
      ];
    };
    nftables.enable = true;
  };
}
