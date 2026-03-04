{ inputs, config, pkgs, lib, ... }:
{
	boot.supportedFilesystems = [ "ntfs" ];
	fileSystems."/mnt/Code"	 = {
		device = "/dev/disk/by-uuid/b95320b3-3df1-4904-a55e-da1e8d819231";
		options = [ "x-systemd.automount" "x-systemd.device-timeout=0" "nofail" ];
	};
	fileSystems."/mnt/Space"	= {
		device = "/dev/disk/by-uuid/0A956B927E2FFFE8";
		fsType = "ntfs-3g";
		options = [ "x-systemd.automount" "x-systemd.device-timeout=0" "rw" "uid=1000" "nofail" ];
	};

    environment.systemPackages = with pkgs; [
		usbutils
		jmtpfs
    ];
}
