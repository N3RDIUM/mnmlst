import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"
import { createState } from "ags";

const [state, setState] = createState({
    visible: true,
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
            <box class="notifd-popup-container">
                asdfh903r8 sdfo
            </box>
        </window>
    )
}

