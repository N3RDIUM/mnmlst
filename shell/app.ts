import { Variable } from "astal";
import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import ping from "./ping/ping.js";

const state = Variable({});

App.start({
    css: style,
    main() {
        shybar(state);
        ping(state);
    },
    requestHandler(req, res) {
        res("ok");
    },
});

