{ inputs, config, pkgs, lib, ... }:
{
	# Enable networking
	networking.networkmanager.enable = true;
	networking.hostName	= "n3rdium-rig";
    networking.extraHosts = ''127.0.1.1 n3rdium-rig.local'';
    networking.interfaces.eno1.ipv4.addresses = [
        { address = "192.168.1.42"; prefixLength = 24; }
    ];
    networking.defaultGateway = "192.168.1.1";
    networking.nameservers = [ "192.168.1.1" "8.8.8.8" ];

    networking.firewall.allowedTCPPorts = [ 5900 5901 8000 5000 8001 ];

    # Avahi
    services.avahi = {
        enable = true;
        ipv4 = true;
        ipv6 = false;
        nssmdns4 = true;
        nssmdns6 = false;
        openFirewall = true;
    };

    # mDNS Setup
    system.nssModules = pkgs.lib.optional true pkgs.nssmdns;
    system.nssDatabases.hosts = pkgs.lib.optionals true (pkgs.lib.mkMerge [
        (pkgs.lib.mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
        (pkgs.lib.mkAfter [ "mdns4" ]) # after dns
    ]);

	# Install firefox.
	programs.firefox.enable = true;

    # Yggdrasil.
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
