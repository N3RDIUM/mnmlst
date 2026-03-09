{ inputs, config, pkgs, lib, ... }:
{
    virtualisation.libvirtd = {
        enable = true;

        qemu = {
            swtpm.enable = true;
        };
    };

    virtualisation.spiceUSBRedirection.enable = true;

    users.groups.libvirtd.members = [ "n3rdium" ];
    users.groups.kvm.members = [ "n3rdium" ];

    environment.systemPackages = with pkgs; [
        gnome-boxes
        dnsmasq
        phodav
    ];
}
