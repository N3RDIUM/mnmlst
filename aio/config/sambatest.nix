{ config, lib, pkgs, ... }:
{
    services.samba = {
        enable = true;
        openFirewall = true;

        settings = {
            global = {
            workgroup = "WORKGROUP";
                "server string" = "nixos-samba";
                "netbios name" = "nixos";
                security = "user";
            };

            public = {
                path = "/srv/samba/public";
                browseable = "yes";
                writable = "yes";
                "read only" = "no";
            };
        };
    };
}
