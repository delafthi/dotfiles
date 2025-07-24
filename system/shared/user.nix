{
  lib,
  pkgs,
  ssh-keys ? [ ],
  user,
  ...
}:
{
  users.users = {
    "${user}" = {
      description = "Thierry Delafontaine";
      home = if pkgs.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = ssh-keys;
    }
    // lib.optionalAttrs pkgs.hostPlatform.isLinux {
      extraGroups = [
        "wheel"
        "audio"
        "dialout"
        "libvirtd"
        "networkmanager"
      ];
      initialPassword = "01234567";
      isNormalUser = true;
    };
  };
}
