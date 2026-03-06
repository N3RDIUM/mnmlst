{ inputs, pkgs, ... }:
{
	imports = [ 
        inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser.enable = true;
    programs.zen-browser.suppressXdgMigrationWarning = true;

    home.packages = with pkgs; [
        wayvnc
        wakeonlan
        element-desktop
		discord
		ani-cli
		mangal
        weylus
        protonvpn-gui
    ];
}

