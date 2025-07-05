import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"

export function Osd(gdkmonitor: Gdk.Monitor) {
    return (
        <window
            visible
            name="bar"
            class="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.IGNORE}
            anchor={Astal.WindowAnchor.BOTTOM}
            application={app}
            margin_bottom={200}
        >
            <centerbox class="osd-container">
                <label
                    $type="center"
                    class="osd-text"
                    label="Welcome to AGS!"
                />
            </centerbox>
        </window>
    )
}

