{pkgs, ...}: {
  imports = [
    ./homebrew.nix
  ];
  environment = {
    darwinConfig = "$HOME/Developer/repos/nix-config/modules/darwin/configuration.nix";
    shellAliases = {
      bash = "${pkgs.bashInteractive}/bin/bash";
    };
    shells = with pkgs; [bashInteractive fish];
    systemPackages = with pkgs; [
      coreutils
      git
      vim
      wget
    ];
  };
  nix = {
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
    gc.automatic = true;
    linux-builder.enable = true;
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@admin"];
    };
  };
  programs = {
    bash = {
      enable = true;
      completion.enable = true;
    };
    fish = {
      enable = true;
      useBabelfish = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    zsh.enable = true;
  };
  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
  services.openssh.enable = true;
  system = {
    activationScripts = {
      installRosetta.text = ''
        softwareupdate --install-rosetta --agree-to-license
      '';
    };
    defaults = {
      CustomSystemPreferences = {
        "com.apple.Safari" = {
          AutoOpenSafeDownloads = false;
        };
      };
      LaunchServices = {
        LSQuarantine = true;
      };
      SoftwareUpdate = {
        AutomaticallyInstallMacOSUpdates = true;
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
    };
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };
    stateVersion = 4;
  };
  users.users = {
    delafthi = {
      description = "Thierry Delafontaine";
      home = "/Users/delafthi";
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIED0iUQ9rApXnM61UGv7Jm4bZx0xCaV+wEPlIShkoy8P openpgp:0x71B978AF"
      ];
    };
  };
}
