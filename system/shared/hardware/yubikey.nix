{ pkgs, ... }:
let
  sudo = if pkgs.stdenv.hostPlatform.isDarwin then "sudo_local" else "sudo";
in
{
  security.pam.services."${sudo}".u2fAuth = true;
}
