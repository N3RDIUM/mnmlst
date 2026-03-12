{ inputs, pkgs, ... }:

{
	home.username = "monitor";
	home.homeDirectory = "/home/monitor";
	home.stateVersion = "24.05"; # Please don't touch

	home.file = {
        ".bash_profile".source = ./.bash_profile;
        ".bashrc".source = ./.bashrc;
        "server.py".source = ./server.py;
	};

    home.packages = with pkgs; [
        tigervnc
        hyprsunset
        (python313.withPackages (ps: with ps; [
            flask
        ]))
        ddcutil
    ];

	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = builtins.readFile (builtins.path {
			path = ./hyprland.conf;
		});
	};

	home.sessionVariables = { EDITOR = "nvim"; };
	programs.home-manager.enable = true;
}
