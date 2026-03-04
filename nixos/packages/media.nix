{ inputs, config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
		mpv
		vlc
    ];
}

