{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" "nct6687" "i2c-dev" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/205f2f4c-92f1-4fbb-8689-6061690c91b4";
        fsType = "ext4";
    };

    fileSystems."/boot" = { 
        device	= "/dev/disk/by-uuid/B1A8-17E3";
        fsType	= "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [
        { 
            device = "/dev/disk/by-uuid/a2aa0657-35c3-41ca-b0eb-1a5e0dd5314c"; 
            options = [ "discard" ];
        }
    ];
    boot.resumeDevice = "/dev/disk/by-uuid/a2aa0657-35c3-41ca-b0eb-1a5e0dd5314c";
    powerManagement.enable = true;

    networking.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
