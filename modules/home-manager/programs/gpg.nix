{ pkgs ? import <nixpkgs> { } }: {
  programs.gpg = {
    enable = true;
  };
  home = {
    file.".gnupg/gpg-agent.conf".text = ''
      default-cache-ttl 86400
      default-cache-ttl-ssh 86400
      enable-ssh-support
      max-cache-ttl 86400
      max-cache-ttl-ssh 86400
      pinentry-program ${pkgs.pinentry_mac}/bin/pinentry-mac
    '';
  };
}
