{ inputs, config, pkgs, lib, ... }:
{
	services.xserver.xkb = {
		layout	= "us";
		variant = "";
	};

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

	services.keyd = {
        enable = true;
        keyboards = {
            default = {
                ids = [ "*" ];
                extraConfig = ''
[main]
capslock = overload(meta, esc);
                '';
            };
        };
    };

    # Weylus
    services.udev.extraRules = ''
        KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
    users.groups.uinput = {};
}
