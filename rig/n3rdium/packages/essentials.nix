{ pkgs, ... }:
{
    home.packages = with pkgs; [
        wl-kbptr
		superfile
		thunar
		kdePackages.okular
        gnome-pomodoro
        libreoffice-fresh
		obsidian
        ollama-vulkan
        wineWow64Packages.waylandFull
        wineWow64Packages.fonts
    ];

    services.gnome-keyring.enable = true;
}
