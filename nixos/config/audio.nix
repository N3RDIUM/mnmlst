{ inputs, config, pkgs, lib, ... }:
{
	services.pulseaudio.enable = false;
	services.pipewire = {
		enable = true;
		alsa.enable	= true;
		alsa.support32Bit = true;
		pulse.enable = true;
        jack.enable = true;
	};
    services.murmur = {
        enable = true;
        openFirewall = true;
        welcometext = "n3rdium's mic server";
    };

	security.rtkit.enable = true;
    security.pam.loginLimits = [
        { domain = "@audio"; type = "-"; item = "rtprio"; value = "95"; }
        { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
        { domain = "@audio"; type = "-"; item = "nice"; value = "-19"; }
    ];

    programs.noisetorch.enable = true;

    environment.systemPackages = with pkgs; [
        rnnoise
        rnnoise-plugin
        mumble
    ];
}
