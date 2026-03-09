{ inputs, pkgs, ... }:

{
	home.username = "monitor";
	home.homeDirectory = "/home/monitor";
	home.stateVersion = "24.05"; # Please don't touch

	home.file = {
        ".bash_profile".source = ./.bash_profile;
        ".bashrc".source = ./.bashrc;
		".config/hypr/hyprland.conf".source = ./hyprland.conf;
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

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    # Allow users in 'video' group to adjust backlight
    systemd.tmpfiles.rules = [
        "z /sys/class/backlight/acpi_video0/brightness 0664 root video -"
    ];

	home.sessionVariables = { EDITOR = "nvim"; };
	programs.home-manager.enable = true;
}
