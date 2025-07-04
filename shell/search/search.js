import { App, Astal, Gtk } from "astal/gtk3";
import { Variable, subprocess } from "astal";

const visible = Variable(false);

export function searchRequestHandler(req, res, state) {
    visible.set(true);
    setTimeout(() => visible.set(false), 1000)
    res("ok");
}

export function searchWidget(state) {
    return <window
        name = "search"
        className = "search"
        namespace = "search"
        monitor = {0}
        exclusivity = {Astal.Exclusivity.IGNORE}
        anchor = ""
        application={App}
    >
        <box className = "SearchWidget" visible={visible()}>
            alsdkfjhasdlkfjhasdlfkjh
        </box>
    </window>;
}

