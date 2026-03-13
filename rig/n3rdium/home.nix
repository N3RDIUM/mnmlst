{ ... }:

{
	imports = [
        ./configs/gui.nix
        ./configs/keyboard.nix

        ./packages/astro.nix
        ./packages/cli.nix
        ./packages/dev.nix
        ./packages/essentials.nix
        ./packages/fonts.nix
        ./packages/media.nix
        ./packages/misc.nix
        ./packages/music.nix
        ./packages/networking.nix
        ./packages/rice.nix
    ];

	home.username = "n3rdium";
	home.homeDirectory = "/home/n3rdium";
	home.stateVersion = "24.05"; # Please don't touch

	home.file = {
		".config/kitty/".source = ./configs/kitty;
		".config/fastfetch/".source = ./configs/fastfetch;
		".config/hypr/".source = ./configs/hypr;
		".config/cava/".source = ./configs/cava;
		".config/atuin/".source = ./configs/atuin;
		".config/nvim/lua".source = ./configs/nvim/lua;
		".config/nvim/init.lua".source = ./configs/nvim/init.lua;
		".config/superfile/".source = ./configs/superfile;
		".zenith/assets/".source = ./assets;
		".config/fish/config.fish".source = ./configs/config.fish;
        ".config/circadian.json".source = ./configs/circadian.json;

        ".wallpapers/".source = ./theming/wallpapers;
        "scripts/".source = ./scripts;
	};

	programs.home-manager.enable = true;
}
