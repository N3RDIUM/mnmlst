import { App, Astal, Gtk } from "astal/gtk3";
import { Variable, timeout } from "astal";
import Hyprland from "gi://AstalHyprland";
import Time from "./widgets/time.js";

const hyprland = Hyprland.get_default();
const timeVisible = Variable(false);

export default function shybar(state) {
    return <window
            name = "shybar"
            className = "shybar"
            namespace = "shybar"
            monitor = {0}
            exclusivity = {Astal.Exclusivity.IGNORE}
            anchor = {
                Astal.WindowAnchor.LEFT |
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.BOTTOM
            }
            application={App}
        >
            <box 
                vertical
                className = { "BarContainer" }
            >
                <box hexpand vexpand />

                <eventbox 
                    onHover = { () => { timeVisible.set(true) } }
                    onHoverLost = { () => { timeVisible.set(false) } }
                >
                    <revealer
                        transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
                        revealChild={timeVisible()}
                    >
                        <Time />
                    </revealer>
                </eventbox>

                <box hexpand vexpand />
            </box>
        </window>;
}

