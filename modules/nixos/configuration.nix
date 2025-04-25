{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "boot.shell_on_fail"
      "quiet"
      "rd.systemd.show_status=auto"
      "splash"
      "udev.log_priority=3"
    ];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      timeout = 0;
    };
    plymouth.enable = true;
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  environment = {
    gnome.excludePackages = with pkgs; [
      cheese
      epiphany
      geary
      gnome-tour
      seahorse
      simple-scan
      totem
      yelp
    ];
    shells = with pkgs; [
      bashInteractive
      fish
    ];
    systemPackages = with pkgs; [
      coreutils
      git
      nautilus-python
      nautilus-open-any-terminal
      vim
      wget
      xclip
    ];
  };
  i18n = {
    defaultLocale = "de_CH.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
    };
  };
  networking = {
    hostName = "Thierrys-MacBook-Air";
    interfaces = {
      enp0s1.useDHCP = true;
    };
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [ "@wheel" ];
    };
  };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  programs = {
    fish.enable = true;
    nix-ld.enable = true;
    steam.enable = true;
    zsh.enable = true;
  };
  time.timeZone = "Europe/Zurich";
  services = {
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [
        "/"
        "/var"
        "/data"
      ];
    };
    displayManager = {
      enable = true;
      defaultSession = "gnome-xorg";
    };
    gnome = {
      gnome-keyring.enable = lib.mkForce false;
    };
    libinput.enable = true;
    openssh = {
      enable = true;
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        X11Forwarding = true;
      };
    };
    printing.enable = true;
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    udev.packages = with pkgs; [
      zsa-udev-rules
      logitech-udev-rules
    ];
    xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
      xkb = {
        layout = "us";
        options = "mac";
      };
    };
  };
  users.users = {
    delafthi = {
      description = "Thierry Delafontaine";
      home = "/home/delafthi";
      initialPassword = "defaultPW";
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
        "dialout"
        "libvirtd"
        "networkmanager"
      ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIED0iUQ9rApXnM61UGv7Jm4bZx0xCaV+wEPlIShkoy8P openpgp:0x71B978AF"
      ];
    };
  };
  virtualisation = {
    libvirtd.enable = true;
    lxd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
