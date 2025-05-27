import { Variable } from "astal";
import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import { ping } from "./ping/ping.js";
import { osd, osdRequestHandler } from "./hud/osd.js";

const state = Variable({
    osd_visible: 1,
    osd_type: "welcome",
    osd_state: [],
    osd_last: Date.now(),
    pain_visible: true
});

function parseRequest(req) {
    return req.toString().split(" ")
}

App.start({
    css: style,
    main() {
        shybar(state);
        ping(state);
        osd(state);
    },
    requestHandler(req, res) {
        req = parseRequest(req);
        let to = req[0];
        let body = req.slice(1, req.length);

        if(to == "osd") {
            osdRequestHandler(body, res, state);
        }
    },
});

