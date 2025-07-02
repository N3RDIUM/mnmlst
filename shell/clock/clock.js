import { App, Astal, Gtk } from "astal/gtk3";
import { Variable, subprocess } from "astal";

const hour = Variable(0).poll(
	1000,
	"date +'%H'",
	(out, prev) => parseInt(out),
);
const minute = Variable(0).poll(
	1000,
	"date +'%M'",
	(out, prev) => parseInt(out),
);

const transform = (v) =>
	v.toString().length % 2 == 0 ? v.toString() : "0" + v.toString();

const visible = Variable(false);

export function timeRequestHandler(req, res, state) {
    visible.set(!visible.get());
    res("ok");
}

export function clock(state) {
    const process = subprocess("python /home/n3rdium/.zenithscripts/clock.py");

    return <window
        name = "clock"
        className = "clock"
        namespace = "clock"
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
                        }, 42);
                    }}
                />
            </box>
            <Gtk.Calendar />
        </box>
    </window>;
}

