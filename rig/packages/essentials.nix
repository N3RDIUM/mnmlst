{ inputs, config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
		pkgs.home-manager
        any-nix-shell
        steam-run
		cmake
		meson
        gnome-keyring
        libsecret
		wget
		curl
        polkit_gnome
        gnupg
        authenticator
        samba
        texliveMedium
    ];

    hardware.graphics = {
        enable = true;
        package = pkgs.mesa;
    };
}
