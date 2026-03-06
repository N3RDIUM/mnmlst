{ config, lib, pkgs, ... }:
# TODO organize
{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings = {
        substituters = [
            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
    };

	# enable experimental features
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # remove bloat
    services.printing.enable = false;
    hardware.bluetooth.enable = false;
    services.pipewire.enable = false;
    programs.ssh.startAgent = false;
    services.displayManager.enable = false;
    services.xserver.enable = false; # no X11

    # Avahi
    services.avahi = {
        enable = true;
        ipv4 = true;
        ipv6 = true;
        nssmdns4 = true;
        nssmdns6 = true;
        publish = {
            enable = true;
            addresses = true;
            workstation = true;
        };
        openFirewall = true;
    };

    # yggdrasil
    services.yggdrasil.enable = true;

    # Boot Optimizations
	systemd.services.systemd-udev-settle.enable	= false;
	systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;

    # wol
    networking = {
        interfaces = {
            eno1 = {
                wakeOnLan.enable = true;
            };
        };
        firewall = {
            allowedUDPPorts = [ 9 8001 ];
        };
    };

    systemd.services.wakeonlan = {
        description = "Enable Wake-on-LAN (WoL)";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.ethtool}/bin/ethtool -s eno1 wol g";
        };
    };

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
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

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.graceful = true;
    boot.loader.timeout = 1;

    services.getty.autologinUser = "n3rdium";

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = [ "n3rdium" ];
            UseDns = false;
            X11Forwarding = false;
            PermitRootLogin = "no";
        };
    };

    networking.networkmanager.enable = true;
    networking.hostName = "n3rdium-lite";
    networking.interfaces.eno1.ipv4.addresses = [
        { address = "192.168.1.37"; prefixLength = 24; }
    ];
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [  "1.1.1.1" "8.8.8.8" ];
    networking.firewall.allowedTCPPorts = [ 22 8001 ];
    networking.networkmanager.unmanaged = [
        "*"     # first unmanage everything
        "!eno1" # then exception: manage eno1
    ];

    time.timeZone = "Asia/Kolkata";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true;
    };

    users.users.n3rdium = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" ]; 
        packages = with pkgs; [
            tree
        ];
    };

    # Git server
{
    users.groups.git = {};

    users.users.git = {
        isSystemUser = true;
        group = "git";
        home = "/home/git";
        createHome = true;
        shell = "${pkgs.git}/bin/git-shell";

        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+OyIQBrmUL0No1td+0lZytP+Kak3WMizPC7pCNTbSt n3rdium"
        ];
    };

    services.openssh.extraConfig = ''
        Match User git
            AllowTcpForwarding no
            AllowAgentForwarding no
            PermitTTY no
            PasswordAuthentication no
            X11Forwarding no
    '';

    services.cgit = {
        enable = true;

        settings = {
            root-title = "N3RDIUM Git";
            root-desc = "Self-hosted repositories";

            scan-path = "/var/lib/git";

            clone-url = "git@n3rdium-lite.local:$CGIT_REPO_URL";

            enable-index-owner = false;
            enable-http-clone = true;
        };
    };

    # env pkgs
    environment.systemPackages = with pkgs; [
        kitty
        neovim
        wget
        git
        wlvncc
        tigervnc
        ethtool
        hyprsunset
        (python313.withPackages (ps: with ps; [
            flask
        ]))
        ddcutil
    ];

    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # Allow users in 'video' group to adjust backlight
    systemd.tmpfiles.rules = [
        "z /sys/class/backlight/acpi_video0/brightness 0664 root video -"
    ];

    system.stateVersion = "25.05";
}
