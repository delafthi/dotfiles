{pkgs, ...}: {
  home = {
    file.".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 30
      default-cache-ttl-ssh 30
      enable-ssh-support
      max-cache-ttl 30
      max-cache-ttl-ssh 30
      pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
    '';
  };
}
