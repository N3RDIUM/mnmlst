{ inputs, config, pkgs, lib, ... }:

{
	imports = [
        ./hardware-configuration.nix

        ./config/amdgpu.nix
        ./config/audio.nix
        ./config/automount.nix
        ./config/boot.nix
        ./config/cli.nix
        ./config/essentials.nix
        ./config/input.nix
        ./config/networking.nix
        ./config/virtualization.nix
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

	users.users = {
		n3rdium = {
			isNormalUser = true;
			description	= "n3rdium";
            shell = pkgs.fish;
			extraGroups	= [ "networkmanager" "wheel" "audio" "jackaudio" "dialout" "uucp" "uinput" "i2c" ];
		};

		not-n3rdium = {
			isNormalUser = true;
			description	= "not-n3rdium";
            shell = pkgs.fish;
			extraGroups	= [ "networkmanager" ];
		};
	};

    environment.variables =
        let
            makePluginPath = format:
            (lib.makeSearchPath format [
                "$HOME/.nix-profile/lib"
                "/run/current-system/sw/lib"
                "/etc/profiles/per-user/$USER/lib"
            ])
            + ":$HOME/.${format}";
        in
        {
            DSSI_PATH = makePluginPath "dssi";
            LADSPA_PATH = makePluginPath "ladspa";
            LV2_PATH = makePluginPath "lv2";
            LXVST_PATH = makePluginPath "lxvst";
            VST_PATH = makePluginPath "vst";
            VST3_PATH = makePluginPath "vst3";
            ROC_ENABLE_PRE_VEGA = "1";
            RUSTICL_ENABLE = "radeonsi";
            EDITOR = "nvim";
        };

	system.stateVersion = "24.11";
}
