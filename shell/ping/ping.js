import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";
import Notifd from "gi://AstalNotifd";

const notifd = Notifd.get_default();
const visibleNotifications = Variable([]);
const hiddenNotifications = Variable([]);
const paneVisible = Variable(0);
let map = {};
let hidden = {};

function rebuildLists() {
    visibleNotifications.set(
        Object.values(map)
            .filter(x => !(x.get_id() in hidden))
            .map(x => <Notification notification = { x }></Notification>)
    );
    hiddenNotifications.set(
        Object.values(map)
            .filter(x => (x.get_id() in hidden))
            .map(x => <Notification notification = { x }></Notification>)
    );
}

notifd.connect("notified", (_, id) => {
    map[id] = notifd.get_notification(id);
    rebuildLists();
});
notifd.connect("resolved", (_, id) => {
    delete map[id];
    rebuildLists();
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

    return <button
        className = "Notification"
        onClicked = {() => {
            if(notification.get_id() in hidden) {
                notification.dismiss();
            }
            hidden[notification.get_id()] = true;
            rebuildLists();
        }}
    >
        <box>
            {
                icon != null ? <box vertical className = "NotificationIconContainer">
                    <icon
                        className = "NotificationIcon"
                        icon = { icon }
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

export function ping(state) {
    return <window
        name = "ping"
        className = "ping"
        namespace = "ping"
        monitor = { 0 }
        exclusivity = { Astal.Exclusivity.IGNORE }
        anchor = {
            Astal.WindowAnchor.RIGHT |
            Astal.WindowAnchor.TOP
        }
        application = { App }
    >
        <eventbox
            onHover = { () => { paneVisible.set(true) } }
            onHoverLost = { () => { paneVisible.set(false) } }
        >
            <box 
                vertical
                className = {paneVisible(v => !v ? "NotificationContainer" : "NotificationContainerActive")}
        >
                <box
                    vertical
                    children = { visibleNotifications() }
                ></box>
                <box className = "NotificationSeparator" visible = { paneVisible() } />
                <box
                    vertical
                    children = { hiddenNotifications() }
                    visible = {paneVisible()}
                ></box>
            </box>
        </eventbox>
    </window>
}

