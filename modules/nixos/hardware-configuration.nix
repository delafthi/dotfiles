{
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "uhci_hcd"
        "virtio_pci"
        "usbhid"
        "usb_storage"
        "sr_mod"
      ];
    };
    kernelModules = [ ];
  };
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvol=root"
        "compress=zstd"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvol=home"
        "compress=zstd"
      ];
    };
    "/nix" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvol=nix"
        "compress=zstd"
        "noatime"
      ];
    };
    "/swap" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvol=swap"
        "noatime"
      ];
    };
    "/var" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvol=var"
        "compress=zstd"
      ];
    };
  };
  hardware = {
    graphics.enable = true;
  };
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  swapDevices = [ { device = "/swap/swapfile"; } ];
}
