import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"
import { createState } from "ags";
import { createPoll } from "ags/time";

function parseVolume(string: String) {
    return Math.round(parseFloat(string.split(": ")[1].replace("%", "")) * 100)
}
function parseMuted(string: String) {
    return string.includes("[MUTED]");
}

const volume = createPoll(
    0,
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseVolume(out),
);
const muted = createPoll(
    false,
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseMuted(out),
);

const [state, setState] = createState({
    visible: false,
    type: "",
});
let timeout = null;

function ClearTimeout() {
    if(timeout != null) {
        clearTimeout(timeout);
    }
}
function StateTimeout(newState, time = 3000) {
    timeout = setTimeout(() => {
        setState(newState)
    }, time);
}

function welcome(req: Array<String>, res: any) {
    ClearTimeout();
    setState({
        visible: true,
        type: "welcome"
    });
    StateTimeout({
        visible: false,
        type: ""
    });
    res("ok");
    return;
}

const requestMap = {
    welcome: welcome
};

export function OsdRequestHandler(req: Array<String>, res: any) {
    let to = req[0];
    let body = req.slice(1, req.length);
    if(requestMap[to] == undefined) {
        res("unknown osd type");
        return;
    };
    requestMap[to](body, res);
}

function OsdTransform(state: Object) {
    if(state.type == "welcome") {
        return "Welcome home, n3rdium!"
    }
    return ""
}

export function Osd(gdkmonitor: Gdk.Monitor) {
    return (
        <window
            name="osd"
            class="osd-window"
            namespace="Osd"
            gdkmonitor={gdkmonitor}
            exclusivity={Astal.Exclusivity.IGNORE}
            anchor={Astal.WindowAnchor.BOTTOM}
            application={app}
            margin_bottom={200}
            visible={state(x => x.visible)}
        >
            <centerbox class="osd-container">
                <label
                    $type="center"
                    class="osd-text"
                    label={state(x => OsdTransform(x))}
                />
            </centerbox>
        </window>
    )
}

