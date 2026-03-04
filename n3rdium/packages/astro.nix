{ pkgs, ... }:
{
    home.packages = with pkgs; [
        gimp
        hugin
		stellarium
        siril
    ];
}
