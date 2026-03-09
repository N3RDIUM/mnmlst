{ inputs, pkgs, ... }:
{
    home.packages = with pkgs; [
		cava
		wofi
		swww
		kooha
        dunst
		hyprshot
		fastfetch
		libnotify
		playerctl
		obs-studio
		hyprpicker
        hyprsunset
        hyprpolkitagent
        wl-clipboard
    ];
}

