{ inputs, config, pkgs, lib, ... }:
{
    # AMDGPU config
    hardware.amdgpu.initrd.enable = true;
    hardware.amdgpu.opencl.enable = false;
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;
    services.lact.enable = true;
    hardware.graphics.extraPackages = with pkgs; [
        mesa
        mesa.opencl
    ];
    services.xserver.videoDrivers = [ "amdgpu" ];

    environment.systemPackages = with pkgs; [
        intel-ocl
        ocl-icd
        clinfo
    ];
}
