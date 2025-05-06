import { Variable } from "astal";
import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import ping from "./ping/ping.js";
import osd from "./hud/osd.js";

const state = Variable({
    "osd-visible": 0,
});

App.start({
    css: style,
    main() {
        shybar(state);
        ping(state);
        osd(state);
    },
    requestHandler(req, res) {
        res("ok");
    },
});

