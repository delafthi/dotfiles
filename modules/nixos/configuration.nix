{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  environment = {
    gnome.excludePackages = with pkgs; [
      cheese
      epiphany
      evince
      geary
      gedit
      gnome-music
      gnome-text-editor
      gnome-tour
      gnome-weather
      seahorse
      simple-scan
      totem
      yelp
    ];
    shells = with pkgs; [ bashInteractive fish ];
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
    hostName = "Thierrys-Workstation";
    interfaces = {
      enp5s0.ipv4.addresses = [
        {
          address = "192.168.1.1";
          prefixLength = 24;
        }
      ];
      enp6s0.ipv4.addresses = [
        {
          address = "192.168.1.100";
          prefixLength = 24;
        }
      ];
    };
    extraHosts = ''
      192.168.1.1 local
    '';
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };
  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["@wheel"];
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
    zsh.enable = true;
  };
  time.timeZone = "Europe/Zurich";
  services = {
    btrbk = {
      instances = {
        local = {
          onCalendar = "hourly";
          settings = {
            timestamp_format = "long";
            snapshot_preserve_min = "2d";
            snapshot_preserve = "14d";
            target_preserve_min = "no";
            target_preserve = "20d 10w *m";
            volume."/" = {
              subvolume = {
                "home" = {
                  snapshot_dir = "home/.snapshots";
                  target = "/run/media/delafthi/c8a565fe-30ad-49e2-899d-d29d1ad4a992";
                };
              };
            };
          };
        };
      };
    };
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = ["/" "/var" "/data"];
    };
    gnome.core-utilities.enable = true;
    libinput.enable = true;
    printing.enable = true;
    udev.packages = with pkgs; [zsa-udev-rules logitech-udev-rules];
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [pkgs.nautilus-open-any-terminal];
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
      initialPassword = "defaultPW";
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "docker" "libvirtd" "networkmanager"];
      shell = pkgs.fish;
    };
  };
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    libvirtd.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
