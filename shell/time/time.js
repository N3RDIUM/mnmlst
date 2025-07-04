import { App, Astal, Gtk } from "astal/gtk3";
import { Variable, subprocess } from "astal";

const visible = Variable(false);

export function timeRequestHandler(req, res, state) {
    visible.set(!visible.get());
    res("ok");
}

export function timeWidget(state) {
    const process = subprocess("python /home/n3rdium/.zenithscripts/clock.py");

    return <window
        name = "time"
        className = "time"
        namespace = "time"
        monitor = {0}
        exclusivity = {Astal.Exclusivity.IGNORE}
        anchor = {
            Astal.WindowAnchor.TOP
        }
        application={App}
    >
        <box className = "TimeWidget" visible={visible()}>
            <box className = "TimeLeft" vertical>
                <icon 
                    icon="/home/n3rdium/.clock.svg"
                    className="Clock"
                    setup = {(self) => {
                        setInterval(() => {
                            self.icon = "/home/n3rdium/.clock.svg";
                        }, 250);
                    }}
                />
            </box>
            <Gtk.Calendar />
        </box>
    </window>;
}

