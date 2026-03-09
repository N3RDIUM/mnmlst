{ pkgs, ... }:
{
    home.packages = with pkgs; [
		ffmpeg
        kdePackages.kdenlive
        pkgsRocm.blender
        rawtherapee
        darktable
        tesseract
        python3Packages.pytesseract
    ];
}
