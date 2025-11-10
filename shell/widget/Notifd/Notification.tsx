import { Gtk } from "ags/gtk4"
import Notifd from "gi://AstalNotifd";

export function Notification(notification: Notifd.Notification) {
    return (
        <box width_request={384} class="notification-container">
            <image
                iconName={notification.appIcon}
                class="notification-icon"
                pixelSize={42}
            ></image>
            <label
                wrap
                wrap_mode={Gtk.WrapMode.WORD}
                max_width_chars={42}
                label = {notification.summary}
            ></label>
        </box>
    );
}
