import app from "ags/gtk4/app"
import theme from "./index.scss"
import { Osd } from "./widget/Osd"

app.start({
    css: theme,
    main() {
        const main_monitor = app.get_monitors()[0];
        Osd(main_monitor);
    },
    requestHandler(request, res) {
        console.log(request);
        res("ok");
    }
})
