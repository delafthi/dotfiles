{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" ];
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/B0A0-692B";
      fsType = "vfat";
    };


  fileSystems."/home" =
    {
      device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "subvol=home" "compress=zstd" ];
    };

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/swap" =
    {
      device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "subvol=swap" "noatime" ];
    };

  fileSystems."/var" =
    {
      device = "/dev/disk/by-uuid/21301508-a3f6-477e-9c7b-6e36c8fa3b0f";
      fsType = "btrfs";
      options = [ "subvol=var" "compress=zstd" "noatime" ];
    };

  swapDevices = [{ device = "/swap/swapfile"; }];

  # Enable sound.
  hardware.pulseaudio.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
