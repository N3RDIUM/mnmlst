import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";

export default function OSD(state) {
    return <window
        name = "OSD"
        className = "OSD"
        monitor = { 0 }
        exclusivity = { Astal.Exclusivity.IGNORE }
        layer = { Astal.Layer.OVERLAY }
        anchor = { Astal.WindowAnchor.BOTTOM }
        application = { App }
        visible = { state(state => state["osd-visible"]) }
    >
        <box
            vertical
            className = "OSDContainer"
        >
        </box>
    </window>
}

