{ inputs, pkgs, ... }:

{
	imports = [ 
        inputs.ags.homeManagerModules.default
        inputs.zen-browser.homeModules.beta
        inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
    ];

	home.username = "n3rdium";
	home.homeDirectory = "/home/n3rdium";
	home.stateVersion = "24.05"; # Please don't touch

	home.packages = with pkgs; [
		# Essentials
		superfile
		xfce.thunar
		kdePackages.okular
        git-credential-oauth
		gcr
        wayvnc
        btop
        gnome-pomodoro
        dunst
        libreoffice-fresh
		obsidian
        protonvpn-gui
        wakeonlan

		# Astro
        gimp
        wineWowPackages.waylandFull
        pkgs.winetricks
		stellarium
        siril

		# Code
		trashy
		lua5_1
		nixd
		gcc
		ruff
		rustup
		python3
		isort
		black
		stylua
		luarocks
		prettierd
		tree-sitter

        # Fonts
        iosevka-bin
        font-awesome
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf

		# Music
        lmms
        audacity
		pavucontrol
		youtube-music
        musescore
        muse-sounds-manager

		# Prod
		ffmpeg
		kdePackages.kdenlive
		blender-hip

		# Rice Stuff
		cava
		wofi
		swww
		kooha
		cmatrix
		pipes-rs
		hyprshot
		fastfetch
		libnotify
		playerctl
		obs-studio
		hyprpicker

		# Shell Stuff
		sl
		fzf
		atuin

		# Oxidised shell stuff
		starship
		zoxide
		fd
		dust
		ripgrep
		ripgrep-all
		tokei
		mprocs

		# Miscellaneous
        ollama-vulkan
		discord
		ani-cli
		mangal

        # Shell stuff
        inputs.astal.packages.${pkgs.system}.io
        inputs.astal.packages.${pkgs.system}.notifd
	];

    programs.hyprcursor-phinger.enable = true;
	wayland.windowManager.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        plugins = [  ];
		extraConfig = builtins.readFile (builtins.path {
			path = ./configs/hypr/hyprland.conf;
		});
	};

    programs.zen-browser.enable = true;

	programs.ags = {
		enable = true;
		configDir = ./shell;
		extraPackages = [
			inputs.ags.packages.${pkgs.system}.notifd
		];
	};

    i18n.inputMethod = {
        type = "fcitx5";
        enable = true;
        fcitx5 = {
            waylandFrontend = true;
            addons = with pkgs; [
                fcitx5-mozc
                fcitx5-gtk
            ];
        };
    };

    fonts = {
        fontconfig = {
            enable = true;
            hinting = "full";

            defaultFonts = {
                serif = [ "Iosevka-Regular" ];
                sansSerif = [ "Iosevka-Regular" ];
                monospace = [ "Iosevka" ];
            };
        };
    };

	programs.git = {
		enable = true;
        package = pkgs.gitFull;
		userName = "n3rdium";
		userEmail = "n3rdium@gmail.com";
		extraConfig = {
			credential.helper = "oauth";
		};
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

	home.file = {
		".config/kitty/".source = ./configs/kitty;
		".config/fastfetch/".source = ./configs/fastfetch;
		".config/cava/".source = ./configs/cava;
		".config/atuin/".source = ./configs/atuin;
		".config/nvim/lua".source = ./configs/nvim/lua;
		".config/nvim/init.lua".source = ./configs/nvim/init.lua;
		".config/superfile/".source = ./configs/superfile;
		".zenith/assets/".source = ./assets;
		".config/fish/config.fish".source = ./configs/config.fish;
	};

	home.sessionVariables = { EDITOR = "nvim"; };
	services.gnome-keyring.enable = true;
	programs.home-manager.enable = true;
}
