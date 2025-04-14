import { Variable } from "astal";
import Hyprland from "gi://AstalHyprland";
import Apps from "gi://AstalApps"

const apps = new Apps.Apps({
    nameMultiplier: 2,
    entryMultiplier: 0,
    executableMultiplier: 2,
})
const hyprland = Hyprland.get_default();

const icon = Variable("/home/n3rdium/.zenithassets/nixos.svg")
hyprland.connect("event", () => {
    let client = hyprland.get_focused_client();
    
    if(client != null) {
        let found = false;
        for (const app of apps.fuzzy_query(client.class)) {
            icon.set(app.get_icon_name());
            found = true;
            break;
        }
    
        if(!found) {
            icon.set("/home/n3rdium/.zenithassets/nixos.svg");
        }
    } else {
        icon.set("/home/n3rdium/.zenithassets/nixos.svg");
    }
});

export default function Icon({ minified }) {
	return (
		<box 
            vertical
            className = {
                minified((value) => value ? "NixOSContainerMini" : "NixOSContainer")
            }
        >
			<icon 
                className = {
                    minified((value) => value ? "NixOSMini" : "NixOS")
                }
                icon = { icon() } 
            />
		</box>
	);
}
