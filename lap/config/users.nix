{ config, lib, pkgs, ... }:
{
    users.users.n3rdium = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; 
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB+OyIQBrmUL0No1td+0lZytP+Kak3WMizPC7pCNTbSt n3rdium"
        ];
    };
    users.users.monitor = {
        isNormalUser = true;
        extraGroups = [ "video" ]; 
    };
}
