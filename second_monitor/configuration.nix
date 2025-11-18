{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];

    # remove bloat
    services.printing.enable = false;
    hardware.bluetooth.enable = false;
    services.pipewire.enable = false;
    services.avahi.enable = false;
    programs.ssh.startAgent = false;
    services.displayManager.enable = false;
    services.xserver.enable = false; # no X11

    # wol
    networking = {
        interfaces = {
            ens3 = {
                wakeOnLan.enable = true;
            };
        };
        firewall = {
            allowedUDPPorts = [ 9 ];
        };
    };

	boot = {
		kernelPackages = pkgs.linuxPackages_latest;
	};

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.graceful = true;
    boot.loader.timeout = 1;

    systemd.services.wakeonlan = {
        description = "Enable Wake-on-LAN (WoL)";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.ethtool}/bin/ethtool -s eno1 wol g";
        };
    };

    services.getty.autologinUser = "n3rdium";

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = [ "n3rdium" ];
            UseDns = true;
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
    networking.nameservers = [ "192.168.1.1" "8.8.8.8" ];
    networking.firewall.allowedTCPPorts = [ 22 ];

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

    environment.systemPackages = with pkgs; [
        kitty
        neovim
        wget
        git
        wlvncc
        ethtool
    ];

    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    system.stateVersion = "25.05";
}
