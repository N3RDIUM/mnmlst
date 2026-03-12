{ config, lib, pkgs, ... }:
{
    services.samba = {
        enable = true;
        openFirewall = true;

        settings = {
            global = {
            workgroup = "WORKGROUP";
                "server string" = "lap-samba";
                "netbios name" = "lap";
                security = "user";
            };

            public = {
                path = "/srv/samba/public";
                browseable = "yes";
                writable = "yes";
                "read only" = "no";
                "guest ok" = "no";
            };
        };
    };

    services.samba-wsdd = {
        enable = true;
        openFirewall = true;
    };
}
