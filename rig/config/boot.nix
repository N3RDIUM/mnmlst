{ inputs, config, pkgs, lib, ... }:
{
	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
        extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
        kernelModules = [ "nct6687" "i2c-dev" ];
        blacklistedKernelModules = [ "nct6683" ];

		loader = {
            grub = {
                enable = true;
                device = "nodev";
                efiSupport = true;
                timeoutStyle = "menu";
            };

            timeout = 1;
            systemd-boot.configurationLimit = 42;
        };
        loader.efi.canTouchEfiVariables = true;

		consoleLogLevel = 4;
		initrd.verbose	= false;
	};

	systemd.services.systemd-udev-settle.enable	= false;
	systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
}
