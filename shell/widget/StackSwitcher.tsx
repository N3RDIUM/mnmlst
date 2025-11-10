import { Gtk } from "ags/gtk4";
import { Accessor } from "gnim";

export function StackSwitcher(
    children: Array<Gtk.Widget>,
    current: Accessor<String>, // だよね？
) {
    if (children.some((ch) => !ch.name))
        throw Error("Every child must have a name");

    return (
        <box>
            <stack
                hexpand
                vexpand
                transition_type={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
                transitionDuration={512}
                visibleChildName={current} // TODO: 何で...
            >
                {children}
            </stack>
        </box>
    );
}
