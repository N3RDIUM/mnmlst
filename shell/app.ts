import app from "ags/gtk4/app"
import theme from "./index.scss"
import { Osd, OsdRequestHandler } from "./widget/Osd/Osd"
import { NotifdPopup } from "./widget/Notifd/Popup.tsx"

function parseRequest(req: String) {
    return req.toString().split(" ")
}

const requestMap = {
    osd: OsdRequestHandler,
    xf86tools: () => { console.log("undecided") },
    xf86homepage: () => { console.log("dashboard") },
    xf86mail: () => { console.log("notifications") },
    xf86explorer: () => { console.log("search") },
    xf86calculator: () => { console.log("assistant") },
};

app.start({
    css: theme,
    main() {
        const main_monitor = app.get_monitors()[0];
        const second_monitor = app.get_monitors()[1];

        Osd(main_monitor);
        NotifdPopup(second_monitor);
    },
    requestHandler(request, res) {
        let req = parseRequest(request);
        let to = req[0];
        let body = req.slice(1, req.length);
        if(requestMap[to] == undefined) {
            res("unknown request");
            return;
        };
        requestMap[to](body, res);
    }
})
