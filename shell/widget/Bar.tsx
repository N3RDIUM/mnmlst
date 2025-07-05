import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { execAsync } from "ags/process"
import { createPoll } from "ags/time"

export default function Bar(gdkmonitor: Gdk.Monitor) {
    const time = createPoll("", 1000, "date")

    return (
        <window
            visible
            name="bar"
            class="Bar"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={0}
            application={app}
        >
            <centerbox cssName="centerbox">
                <button
                    $type="start"
                    onClicked={() => execAsync("echo hello").then(console.log)}
                    hexpand
                    halign={Gtk.Align.CENTER}
                >
                    <label label="Welcome to AGS!" />
                </button>
                <box $type="center" />
                <menubutton $type="end" hexpand halign={Gtk.Align.CENTER}>
                    <label label={time} />
                    <popover>
                        <Gtk.Calendar />
                    </popover>
                </menubutton>
            </centerbox>
        </window>
    )
}
