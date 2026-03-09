{ config, lib, pkgs, ... }:
{
	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
		consoleLogLevel = 4;
		initrd.verbose	= false;
	};

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.graceful = true;
    boot.loader.timeout = 1;

	systemd.services.systemd-udev-settle.enable	= false;
	systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;

    services.getty.autologinUser = "monitor";
}
