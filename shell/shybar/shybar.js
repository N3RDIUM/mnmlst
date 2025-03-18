import { App, Astal } from "astal/gtk3";
import { Variable, bind } from "astal";
import NixOS from "./widgets/nixos.js";
import Workspaces from "./widgets/workspaces.js";
import Time from "./widgets/time.js";
import { Tray, TrayWidgets } from "./widgets/tray.js"

function Separator() {
    return <box className="Separator" />
}

export default function shybar() {
    return <window
            name = "ShyBar"
            className = "ShyBar"
            monitor = {0}
            exclusivity = {Astal.Exclusivity.EXCLUSIVE}
            anchor = {
                Astal.WindowAnchor.RIGHT |
                Astal.WindowAnchor.TOP |
                Astal.WindowAnchor.BOTTOM
            }
            application={App}
        >
            <box vertical className = "BarContainer" >
                <NixOS />
                <Separator />
                <Workspaces />
                <Separator />

                <box hexpand vexpand />

                <Separator />
                <Time /> 
                <Separator />
                <Tray />
                <TrayWidgets />
            </box>
        </window>;
}

