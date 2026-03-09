{ inputs, config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
		cpio
        efibootmgr
        fancontrol-gui
        ddcutil
    ];
}
