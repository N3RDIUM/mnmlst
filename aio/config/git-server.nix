{ config, lib, pkgs, ... }:
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
}
