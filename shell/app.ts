import { App } from "astal/gtk3";
import style from "./style.css";
import shybar from "./shybar/shybar.js";

App.start({
    css: style,
    main() {
        shybar(); 
    },
    requestHandler(req, res) {
        res("ok");
    },
});

