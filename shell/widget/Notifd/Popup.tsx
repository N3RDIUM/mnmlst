import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import { createState } from "ags"
import Notifd from "gi://AstalNotifd";
import { Notification } from "./Notification";
import { For, Accessor } from "ags"

const notifd = Notifd.get_default();
notifd.set_ignore_timeout(true);

var map = [];
const [state, setState] = createState({
    visible: true,
});
const [notifications, setNotifications] = createState([]);

function rebuildList() {
    const value = Object.values(map).map(Notification);
    setNotifications(value);
}

notifd.connect("notified", (_, id) => {
    map[id] = notifd.get_notification(id);
    rebuildList();
});
notifd.connect("resolved", (_, id) => {
    delete map[id];
    rebuildList();
});

export function NotifdPopup(gdkmonitor: Gdk.Monitor) {
    return (
        <window
            name="notifd-popup"
            class="notifd-popup"
            namespace="NotifdPopup"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.IGNORE}
            anchor={
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.RIGHT
            }
            application={app}
            margin_top={12}
            margin_right={12}
            visible={state(x => x.visible)}
        >
            <box 
                orientation={Gtk.Orientation.VERTICAL}
            >
                <For each={notifications}>
                  {(item, index: Accessor<number>) => item}
                </For>
            </box>
        </window>
    )
}

