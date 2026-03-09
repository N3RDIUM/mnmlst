{ config, lib, pkgs, ... }:
{
	users.users = {
		n3rdium = {
			isNormalUser = true;
			description	= "n3rdium";
            shell = pkgs.fish;
			extraGroups	= [
                "wheel"
                "networkmanager"
                "audio"
                "jackaudio"
                "dialout"
                "uucp"
                "uinput"
                "i2c"
            ];
		};

		not-n3rdium = {
			isNormalUser = true;
			description	= "not-n3rdium";
            shell = pkgs.fish;
			extraGroups	= [ "networkmanager" ];
		};
	};
}
