{ inputs, pkgs, ... }:

{
	home.username = "n3rdium";
	home.homeDirectory = "/home/n3rdium";
	home.stateVersion = "24.05"; # Please don't touch

	home.file = {
        ".bash_profile".source = ./.bash_profile;
        ".bashrc".source = ./.bashrc;
        ".config/nvim".source = ../configs/nvim;
		".confrg/hypr/hyprland.conf".source = ./hyprland.conf;
        "server.py".source = ./server.py;
	};

	home.sessionVariables = { EDITOR = "nvim"; };
	programs.home-manager.enable = true;
}
