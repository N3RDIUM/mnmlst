{ pkgs, ... }:
{
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

    services.cliphist = {
        enable = true;
        systemdTargets = ["default.target"];
        extraOptions = [
            "-max-dedupe-search"
            "10"
            "-max-items"
            "65536"
        ];
        allowImages = true;
    };
}
