{ pkgs, ... }:
{
    home.packages = with pkgs; [
        iosevka-bin
        font-awesome
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
    ];

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
}
