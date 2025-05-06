import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";
import ping from "./ping/ping.js";

App.start({
    css: style,
    main() {
        shybar();
        ping();
    },
    requestHandler(req, res) {
        res("ok");
    },
});

