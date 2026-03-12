{ config, lib, pkgs, ... }:
{
    services.printing.enable = false;
    hardware.bluetooth.enable = false;
    services.pipewire.enable = false;
    programs.ssh.startAgent = false;
    services.displayManager.enable = false;
    services.xserver.enable = false;
}
