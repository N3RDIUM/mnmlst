import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";

function OSDWidget({ state }) {
    let content;
    
    if(state.osd_type == "welcome") {
        content = <box className="OSDText">
            <box hexpand />
            Welcome home, n3rdium!
            <box hexpand />
        </box>;
    } else if(state.osd_type == "volume") {
        content = <box className="OSDText">
            <box hexpand />
            {state.osd_state[1]} Volume: {state.osd_state[0]}%
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
        name = "OSD"
        className = "OSD"
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

