import { App, Astal } from "astal/gtk3";
import { Variable, bind, exec } from "astal";

function parseVolume(string) {
    return Math.round(parseFloat(string.split(": ")[1].replace("%", "")) * 100)
}
function parseMuted(string) {
    return string.includes("[MUTED]");
}

const volume = Variable(0).poll(
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseVolume(out),
);
const muted = Variable(false).poll(
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseMuted(out),
);

function OSDWidget({ state }) {
    let content;
    
    if(state.osd_type == "welcome") {
        content = <box className="OSDText">
            <box hexpand />
            Welcome home, n3rdium!
            <box hexpand />
        </box>;
    } else if(state.osd_type == "volume") {
        let current = {
            volume: volume.get(),
            muted: muted.get()
        };

        let volume_icon = "";
        if(current.volume < 20) {
            volume_icon = "";
        }
        if(current.muted) {
            volume_icon = "";
        }

        content = <box className="OSDText">
            <box hexpand />
            {volume_icon} Volume: {current.volume.toString()}%
            <box hexpand />
        </box>
    } else if(state.osd_type == "circadian") {
        content = <box className="OSDText">
            <box hexpand />
            {state.osd_state[1]} Warmth: {state.osd_state[0]}
            <box hexpand />
        </box>
    }

    return <box>{ content }</box>;
}

export function osd_request_handler(req, res, state) {
    let osd_type = req[0]
    let osd_state = req.slice(1, req.length);
    state.set({
        osd_visible: true,
        osd_type: osd_type,
        osd_state: osd_state,
        osd_last: Date.now()
    });
    res("ok");
}

export function osd(state) {
    return <window
        name = "osd"
        className = "osd"
        namespace = "osd"
        monitor = { 0 }
        exclusivity = { Astal.Exclusivity.IGNORE }
        layer = { Astal.Layer.OVERLAY }
        anchor = { Astal.WindowAnchor.BOTTOM }
        application = { App }
        visible = { state(state => state.osd_visible) }
        setup = {() => {
            setInterval(() => {
                let current = JSON.parse(JSON.stringify(state.get()));
                if(Date.now() - current.osd_last > 2424) {
    current.osd_visible = false;
                    state.set(current);
                }
            }, 100)
        }}
    >
        <box
            vertical
            className = "OSDContainer"
            children = { state(value => <OSDWidget state = { value } />) }
        >
        </box>
    </window>
}

