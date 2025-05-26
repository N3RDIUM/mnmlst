import { Variable } from "astal";
import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import { ping } from "./ping/ping.js";
import { osd, osd_request_handler } from "./hud/osd.js";
import pain from "./pain/pain.js";

const state = Variable({
    osd_visible: 1,
    osd_type: "welcome",
    osd_state: [],
    osd_last: Date.now()
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
        pain(state);
    },
    requestHandler(req, res) {
        req = parseRequest(req);
        if(req[0] == "osd") {
            osd_request_handler(req.slice(1, req.length), res, state);
        }
    },
});

