{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "compress=zstd" "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=nix" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "compress=zstd" "noatime" "subvol=var" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "noatime" "subvol=swap" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/B0A0-692B";
      fsType = "vfat";
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
