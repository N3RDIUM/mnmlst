{ config, lib, pkgs, ... }:
{
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

    # wol
    networking = {
        firewall = {
            allowedUDPPorts = [ 9 8001 ];
        };
    };

    # Networking
    networking.networkmanager.enable = true;
    networking.hostName = "n3rdium-lap";
    networking.interfaces.eno1.ipv4.addresses = [
        { address = "192.168.1.69"; prefixLength = 24; }
    ];
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [  "1.1.1.1" "8.8.8.8" ];
    networking.firewall.allowedTCPPorts = [ 22 8001 ];

    # This stuff
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    # Yggdrasil
    services.yggdrasil = {
        enable = true;
        persistentKeys = true;
        settings = {
            Peers = [
                "tls://astrra.space:55535"
                "tls://153.120.42.137:54232"
                "tls://asia.deinfra.org:15015"
                "tcp://yg-sin.magicum.net:23901"
            ];
        };
    };
}
