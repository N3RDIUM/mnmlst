{ config, lib, pkgs, ... }:
{
    imports = [
        ./hardware-configuration.nix
        
        ./config/boot.nix
        ./config/git-server.nix
        ./config/locale.nix
        ./config/networking.nix
        ./config/nobloat.nix
        ./config/samba-server.nix
        ./config/ssh-server.nix
        ./config/users.nix
    ];

    # cachix stuff
    nix.settings = {
        substituters = [
            "https://nix-community.cachix.org"
            "https://hyprland.cachix.org"
        ];
        trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        ];
    };

	# enable experimental features
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # graphics
    hardware.graphics.enable = true;

    # home-manager stuff
    environment.pathsToLink = [
        "/share/applications"
        "/share/xdg-desktop-portal"
    ];

    # env pkgs
    environment.systemPackages = with pkgs; [
        kitty
        neovim
        wget
        git
        ethtool
    ];

    system.stateVersion = "25.05";  # please dont touch
}
