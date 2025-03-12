import { App, Astal } from "astal/gtk3";
import { Variable, bind, exec } from "astal";

const visible = Variable(false);

function Cook({ profile }) {
    return <button
        hexpand
        vexpand
        className = "CookItem"
        onClick = { () => { startup(profile); visible.set(false); } } 
    >
        <icon className = "CookIcon" icon = { iconPath(profile) } />
    </button>;
}

function startup(profile) {
    exec(`python3 /home/n3rdium/.zenithscripts/startup.py ${profile}`);
}

function iconPath(profile) {
    return `/home/n3rdium/.zenithassets/${profile}.svg`
}

export default function whatcook() {
    return <window
        className = "WhatCook"
        monitor = {0}
        exclusivity = {Astal.Exclusivity.IGNORE}
        anchor = {
            Astal.WindowAnchor.CENTER
        }
        visible = { bind(visible) }
    >
        <box vertical className="WhatCookContainer">
            <box vexpand hexpand className="WhatCookRow">
                <Cook profile = "study" />
                <Cook profile = "code" />
                <Cook profile = "astro" />
                <Cook profile = "writing" />
            </box>
            <box vexpand hexpand className="WhatCookRow">
                <Cook profile = "music" />
                <Cook profile = "focus" />
                <Cook profile = "chillout" />
                <Cook profile = "nothing" />
            </box>
        </box>
    </window>;
}

