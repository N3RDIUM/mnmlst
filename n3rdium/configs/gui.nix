{ inputs, pkgs, ... }:
{
	imports = [ 
        inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
        inputs.ags.homeManagerModules.default
    ];

    programs.hyprcursor-phinger.enable = true;
	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        plugins = [ 
        ];
		extraConfig = builtins.readFile (builtins.path {
			path = ./hypr/hyprland.conf;
		});
	};

	gtk = {
		enable = true;

		theme = {
			name = "Gruvbox-Dark";
			package = pkgs.gruvbox-gtk-theme;
		};

		iconTheme = {
			name = "oomox-gruvbox-dark";
			package = pkgs.gruvbox-dark-icons-gtk;
		};
	};

	qt = {
		enable = true;
		platformTheme.name = "gtk";
	};

	programs.ags = {
		enable = true;
		configDir = ./ags;
		extraPackages = [
			inputs.ags.packages.${pkgs.system}.notifd
		];
	};
    home.packages = [
        inputs.astal.packages.${pkgs.system}.io
        inputs.astal.packages.${pkgs.system}.notifd
    ];
}

