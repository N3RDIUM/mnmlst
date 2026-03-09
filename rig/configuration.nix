{ inputs, config, pkgs, lib, ... }:

{
	imports = [
        ./hardware-configuration.nix

        ./config/amdgpu.nix
        ./config/audio.nix
        ./config/automount.nix
        ./config/boot.nix
        ./config/cli.nix
        ./config/env.nix
        ./config/essentials.nix
        ./config/input.nix
        ./config/users.nix
        ./config/networking.nix
        # ./config/virtualization.nix
        ./config/wm.nix

        ./packages/dev.nix
        ./packages/essentials.nix
        ./packages/hardwarectl.nix
        ./packages/media.nix
    ];

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

	system.stateVersion = "24.11";
}
