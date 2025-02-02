{ inputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment = {
    etc =
      lib.mapAttrs'
        (name: value: {
          name = "nix/path/${name}";
          value.source = value.flake;
        })
        config.nix.registry;
    gnome.excludePackages = (with pkgs; [
      gedit
      gnome-text-editor
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese
      epiphany
      evince
      geary
      gnome-music
      gnome-weather
      seahorse
      simple-scan
      totem
      yelp
    ]);
    pathsToLink = [ "/share/zsh" ];
    systemPackages = with pkgs; [
      git
      gnome.nautilus-python
      inputs.home-manager.packages.${pkgs.system}.default
      nautilus-open-any-terminal
      vim
      wget
      xclip
    ];
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = [ "nix-command" "flakes" ];
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # Configure networking
  networking = {
    hostName = "thierrys-workstation";
    interfaces = {
      enp5s0.ipv4.addresses = [{
        address = "192.168.1.1";
        prefixLength = 24;
      }];
      enp6s0.ipv4.addresses = [{
        address = "192.168.1.100";
        prefixLength = 24;
      }];
    };
    extraHosts = ''
      192.168.1.1 local
    '';
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "de_CH.UTF-8";
    extraLocaleSettings = {
      LC_MESSAGES = "en_US.UTF-8";
    };
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    delafthi = {
      description = "Thierry Delafontaine";
      initialPassword = "defaultPW";
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" "docker" "libvirtd" "networkmanager" ];
      shell = pkgs.zsh;
    };
  };
  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
  };

  services = {
    # Enable snapshots of home (Btrfs)
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
    # Enable scrubbing (Btrfs)
    btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" "/var" "/data" ];
    };

    gnome.core-utilities.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;

    # Add udev rules to flash ergodox keyboard
    udev.packages = [ pkgs.zsa-udev-rules ];

    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      displayManager.gdm.enable = true;
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.nautilus-open-any-terminal ];
      };
      xkb = {
        layout = "us";
        options = "mac";
      };
      libinput.enable = true;
    };
  };

  # Enable virtualisation services
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
