{ config, lib, pkgs, ... }:
{
    services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = true;
            AllowUsers = [ 
                "n3rdium" 
                "muke"
                "git" 
            ];
            UseDns = false;
            X11Forwarding = false;
            PermitRootLogin = "no";
        };
    };

    services.fail2ban.enable = true;
}

