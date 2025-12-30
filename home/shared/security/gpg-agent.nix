{ lib, pkgs, ... }:
{
  programs.bash.initExtra = lib.mkIf pkgs.stdenv.hostPlatform.isLinux ''
    export SSH_AUTH_SOCK=$(${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
  '';
  programs.fish.interactiveShellInit = lib.mkIf pkgs.stdenv.hostPlatform.isLinux ''
    set -gx SSH_AUTH_SOCK (${pkgs.gnupg}/bin/gpgconf --list-dirs agent-ssh-socket)
  '';
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 30;
    defaultCacheTtlSsh = 30;
    enableExtraSocket = true;
    enableSshSupport = true;
    maxCacheTtl = 30;
    maxCacheTtlSsh = 30;
    pinentry.package =
      if pkgs.stdenv.hostPlatform.isDarwin then pkgs.pinentry_mac else pkgs.pinentry-gnome3;
  };
}
