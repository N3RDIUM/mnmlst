{ inputs, config, pkgs, lib, ... }:
{
	boot.supportedFilesystems = [ "ntfs" ];
	fileSystems."/mnt/code"	 = {
		device = "/dev/disk/by-uuid/b95320b3-3df1-4904-a55e-da1e8d819231";
		options = [ "x-systemd.automount" "x-systemd.device-timeout=0" "nofail" ];
	};
	fileSystems."/mnt/space"	= {
		device = "/dev/disk/by-uuid/0A956B927E2FFFE8";
		fsType = "ntfs-3g";
		options = [ "x-systemd.automount" "x-systemd.device-timeout=0" "rw" "uid=1000" "nofail" ];
	};
    fileSystems."/mnt/aio" = {
        device = "//n3rdium-lite.local/public";
        fsType = "cifs";
        options = let
            automount_opts = "uid=1000,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
            in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };
    fileSystems."/mnt/lap" = {
        device = "//n3rdium-lap.local/public";
        fsType = "cifs";
        options = let
            automount_opts = "uid=1000,x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
            in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
    };

    environment.systemPackages = with pkgs; [
		usbutils
		jmtpfs
    ];
}
