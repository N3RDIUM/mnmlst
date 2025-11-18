{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
    ];

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.graceful = true;

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

    services.printing.enable = false;

    users.users.n3rdium = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" ]; 
        packages = with pkgs; [
            tree
        ];
    };

    environment.systemPackages = with pkgs; [
        kitty
        vim
        wget
        git
        multivnc
    ];

    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    system.stateVersion = "25.05";
}
