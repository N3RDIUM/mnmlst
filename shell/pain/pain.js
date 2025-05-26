// The name "pain" is NOT a misspelling. It's deliberate.

import { App, Astal, Gtk } from "astal/gtk3";
import { Variable } from "astal";
import { notifications } from "../ping/ping.js";

const screen = Variable("Ping");
const visible = Variable(false);

function StackSwitcher({ children }) {
    if (children.some((ch) => !ch.name))
        throw Error("Every child must have a name");

    return (
        <box>
            <stack
                hexpand
                vexpand
                transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
                transitionDuration={512}
                visibleChildName={screen()}
            >
                {children}
            </stack>
        </box>
    );
}

export default function pain(state) {
    return <window
        name = "pain"
        className = "pain"
        namespace = "pain"
        monitor = {0}
        exclusivity = {Astal.Exclusivity.EXCLUSIVE}
        anchor = {
            Astal.WindowAnchor.RIGHT |
            Astal.WindowAnchor.TOP |
            Astal.WindowAnchor.BOTTOM
        }
        application = {App}
        visible = {visible()}
    >
        <box className={"PaneContainer"} vertical hexpand vexpand>
            <StackSwitcher>
                <box name="Ping">
                    <box
                        vertical
                        children = { notifications() }
                    ></box>
                    <box vexpand hexpand />
                </box>
                <box name="Clock">
                    Klokk
                </box>
            </StackSwitcher>
        </box>
    </window>;
}

