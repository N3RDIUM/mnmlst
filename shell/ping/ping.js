import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";

function Notification({ notification, state }) {
    return <eventbox>
        <box
            className = "Notification"
        >
            <box vertical className = "NotificationIconContainer">
                <icon
                    className = "NotificationIcon"
                    icon = "kitty"
                />
                <box vexpand></box>
            </box>
            <box vertical className = "NotificationContent">
                <box>
                    <label className = "NotificationSummary" wrap>{ notification.get_summary() }</label>
                    <box hexpand></box>
                    <button
                        className = "NotificationAction"
                        onClicked = {() => {
                            console.log("Hide", notification.get_id());
                        }}
                    >
                        
                    </button>
                    <button
                        className = "NotificationAction"
                        onClicked = {() => {
                            console.log("Close", notification.get_id());
                        }}
                    >
                        
                    </button>
                </box>
                <box>
                    <label className = "NotificationBody" wrap>{ notification.get_body() }</label>
                    <box hexpand></box>
                </box>
            </box>
        </box>
    </eventbox>
}

export default function Ping(state) {
    const notifd = Notifd.get_default();
    const visibleNotifications = Variable([]);
    let map = {};

    function rebuildList() {
        visibleNotifications.set(Object.values(map).map(x => <Notification notification = { x } state = { state }></Notification>));
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
        ></box>
    </window>
}

