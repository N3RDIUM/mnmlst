import Notifd from "gi://AstalNotifd";

export default function Ping() {
    const notifd = Notifd.get_default();

    notifd.connect("notified", (_, id) => {
        console.log(_, id, notifd.get_notification(id));
    });
    notifd.connect("resolved", (_, id) => {
        console.log(_, id, "resolved");
    });
}

