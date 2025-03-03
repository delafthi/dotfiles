{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod"];
    };
    kernelModules = ["kvm-intel"];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/48d32129-4897-4f45-a446-8dd51e6d67b6";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0725-148A";
      fsType = "vfat";
    };
    "/data" = {
      device = "/dev/disk/by-uuid/3aee4c5c-e05c-436c-869d-86f3026002ed";
      fsType = "btrfs";
      options = ["subvol=data" "compress=zstd"];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/48d32129-4897-4f45-a446-8dd51e6d67b6";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/48d32129-4897-4f45-a446-8dd51e6d67b6";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };
    "/swap" = {
      device = "/dev/disk/by-uuid/48d32129-4897-4f45-a446-8dd51e6d67b6";
      fsType = "btrfs";
      options = ["subvol=swap" "noatime"];
    };
    "/var" = {
      device = "/dev/disk/by-uuid/4963e7af-2b23-455d-9c7d-c83d360d893e";
      fsType = "btrfs";
      options = ["subvol=var" "compress=zstd"];
    };
  };
  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  swapDevices = [{device = "/swap/swapfile";}];
}
