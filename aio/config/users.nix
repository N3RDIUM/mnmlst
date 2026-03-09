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
    users.users.mewk = {
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO1uMcSBn819iv8jLHl9GnnwYHCZdkiSmFcxdap2DUrX mewk"
        ];
    };

    # Allow users in 'video' group to adjust backlight
    systemd.tmpfiles.rules = [
        "z /sys/class/backlight/acpi_video0/brightness 0664 root video -"
    ];
}
