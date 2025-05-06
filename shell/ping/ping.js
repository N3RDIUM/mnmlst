import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";

function Notification({ notification }) {
    return <box
        className = "Notification"
        vertical
    >
        { notification.get_summary() }
        { notification.get_body() }
    </box>
}

export default function Ping(state) {
    const notifd = Notifd.get_default();
    const visibleNotifications = Variable([]);
    let map = {};

    function rebuildList() {
        visibleNotifications.set(Object.values(map).map(x => <Notification notification = { x }></Notification>))
    }

    notifd.connect("notified", (_, id) => {
        map[id] = notifd.get_notification(id);
        rebuildList(id);
    });
    notifd.connect("resolved", (_, id) => {
        delete map[id];
        rebuildList(id);
    });

    return <window
        name = "Ping"
        className = "Ping"
        monitor = { 0 }
        exclusivity = { Astal.Exclusivity.IGNORE }
        anchor = {
            Astal.WindowAnchor.RIGHT |
            Astal.WindowAnchor.TOP
        }
        application = { App }
    >
        <box
            vertical
            className = "NotificationContainer"
            children = { visibleNotifications() }
        >
        </box>
    </window>
}

