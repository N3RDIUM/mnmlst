import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";

const notifd = Notifd.get_default();
const visibleNotifications = Variable([]);
let map = {};
let hidden = {};

function rebuildList() {
    visibleNotifications.set(
        Object.values(map)
            .filter(x => !(x.get_id() in hidden))
            .map(x => <Notification notification = { x }></Notification>)
    );
}

notifd.connect("notified", (_, id) => {
    map[id] = notifd.get_notification(id);
    rebuildList();
});
notifd.connect("resolved", (_, id) => {
    delete map[id];
    rebuildList();
});

function Notification({ notification, state }) {
    let icon = null;
    if(notification.get_app_icon()) {
        icon = notification.get_app_icon();
    }
    if(notification.get_image()) {
        icon = notification.get_image();
    }

    // TODO: Play audio file, custom actions,
    // TODO: hide to pane notification list

    return <button
        className = "Notification"
        onClicked = {() => {
            hidden[notification.get_id()] = true;
            rebuildList();
        }}
    >
        <box>
            {
                icon != null ? <box vertical className = "NotificationIconContainer">
                    <icon
                        className = "NotificationIcon"
                        icon = "kitty"
                    />
                    <box vexpand></box>
                </box> : <box css="min-width: 6px;"></box>
            }
            <box vertical className = "NotificationContent">
                <box>
                    <label className = "NotificationSummary" wrap>{ notification.get_summary() }</label>
                    <box hexpand></box>
                </box>
                <box>
                    <label className = "NotificationBody" wrap>{ notification.get_body() }</label>
                    <box hexpand></box>
                </box>
            </box>
        </box>
    </button>
}

export default function Ping(state) {
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

