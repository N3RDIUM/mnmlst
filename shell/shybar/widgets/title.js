import { Variable } from "astal";
import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

function limitString(str, maxLength) {
    return str.length > maxLength ? str.slice(0, maxLength) + '...' : str;
}

const title = Variable("");
hyprland.connect("event", () => {
    let client = hyprland.get_focused_client();
    
    if(client != null) {
        title.set(limitString(client.title, 42));
    } else {
        title.set("");
    }
})

export default function Title({ minified }) {
    return <box>
        {
            minified((v) => v ? <label angle = {90} className = "WindowTitle" label={ title() } /> : "")
        }
    </box>
}

