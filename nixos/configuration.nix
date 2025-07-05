{ inputs, config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];
		
	# Bootloader.
	boot = {
		# Latest kernel
		kernelPackages = pkgs.linuxPackages_xanmod_latest;

		# Grub
		loader.grub = {
			enable			 = true;
			device			 = "nodev";
			efiSupport	 = true;
			timeoutStyle = "menu";
		};
		loader.efi.canTouchEfiVariables = true;

		### Boot animation
		plymouth.enable = true;
		consoleLogLevel = 4;
		initrd.verbose	= false;
		kernelParams = [
			"quiet"
			"splash"
			"boot.shell_on_fail"
			"loglevel=3"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];
	};

	systemd.services.systemd-udev-settle.enable	= false;
	systemd.services.NetworkManager-wait-online.enable = false;

    # Nix storage optimizations
    nix.optimise.automatic = true;
    nix.optimise.dates = [ "04:00" ];

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };

	# OpenGL
	hardware.graphics.enable = true;

	# Whatever this is
	programs.dconf.enable = true;		

	# Enable networking
	networking.networkmanager.enable = true;
	networking.hostName	= "n3rdiums-machine";

	# Enable experimental features
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Set your time zone.
	time.timeZone = "Asia/Kolkata";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY	= "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};

	services.keyd = {
        enable = true;
        keyboards = {
            default = {
                ids = [ "*" ];
                extraConfig = ''
[main]
capslock = overload(meta, esc);
                '';
            };
        };
    };

    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
            ];
        };
    };

	# Enable SDDM and KDE Plasma
	services.displayManager.sddm = {
		enable				 = true;
		wayland.enable = true;
	};
	services.desktopManager.plasma6.enable = true;

	# Fish
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;

	# Configure keymap in X11
	services.xserver.xkb = {
		layout	= "us";
		variant = "";
	};

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable			= true;
	services.pipewire = {
		enable						= true;
		alsa.enable			 = true;
		alsa.support32Bit = true;
		pulse.enable			= true;
	};

	# Define user accounts.
	users.users = {
		n3rdium = {
			isNormalUser = true;
			description	= "n3rdium";
			extraGroups	= [ "networkmanager" "wheel" ];
		};

		not-n3rdium = {
			isNormalUser = true;
			description	= "not-n3rdium";
			extraGroups	= [ "networkmanager" ];
		};
	};

	# Install firefox.
	programs.firefox.enable = true;

    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile.
	environment.variables.EDITOR = "nvim";
	environment.systemPackages	 = with pkgs; [
		pkgs.home-manager
		usbutils
		jmtpfs
		mpv
		vlc
		git
		neovim
		wget
		curl
		kitty
		cmake
		meson
		cpio
		xdg-desktop-portal-hyprland
		xdg-desktop-portal-gtk
	];

	# Automount
	boot.supportedFilesystems = [ "ntfs" ];
	fileSystems."/mnt/Code"	 = {
		device = "/dev/disk/by-uuid/b95320b3-3df1-4904-a55e-da1e8d819231";
		options = [ "nofail" ];
	};
	fileSystems."/mnt/Space"	= {
		device = "/dev/disk/by-uuid/0A956B927E2FFFE8";
		fsType = "ntfs-3g";
		options = [ "rw" "uid=1000" "nofail" ];
	};

	system.stateVersion = "24.11";
}
