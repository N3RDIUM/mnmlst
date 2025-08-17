import app from "ags/gtk4/app"
import { Astal, Gdk } from "ags/gtk4"
import { createState } from "ags";
import { welcomeTransform } from "./welcome";
import { volumeTransform } from "./volume";

const [state, setState] = createState({
    visible: false,
    type: "",
});
let timeout = null;

function setTypeFor(type: String, time = 3000) {
    if(timeout != null) {
        clearTimeout(timeout);
    }

    setState({
        visible: true,
        type: type,
    });

    timeout = setTimeout(() => setState({
        visible: false,
        type: ""
    }), time);
}

export function OsdRequestHandler(req: Array<String>, res: any) {
    let type = req[0];
    let body = req.slice(1, req.length);

    let time = body[0];
    if(time == undefined) {
        time = 3000;
    }
    setTypeFor(type, time);
    res("ok");
}

const transformMap = {
    welcome: welcomeTransform,
    volume: volumeTransform,
}

function osdTextTransform(state: Object) {
    let { type } = state;
    if(transformMap[type] == undefined) {
        return "Unknown OSD Type: " + type;
    }
    return transformMap[type](state);
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
                    label={state(x => osdTextTransform(x))}
                />
            </centerbox>
        </window>
    )
}

