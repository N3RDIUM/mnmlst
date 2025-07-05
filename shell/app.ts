import app from "ags/gtk4/app"
import theme from "./index.scss"
import { Osd, OsdRequestHandler } from "./widget/Osd"

function parseRequest(req: String) {
    return req.toString().split(" ")
}

const requestMap = {
    osd: OsdRequestHandler
};

app.start({
    css: theme,
    main() {
        const main_monitor = app.get_monitors()[0];
        Osd(main_monitor);
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
