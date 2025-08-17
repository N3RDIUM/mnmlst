import { exec } from "ags/process";

function parseVolume(string: String) {
    return Math.round(parseFloat(string.split(": ")[1].replace("%", "")) * 100)
}
function parseMuted(string: String) {
    return string.includes("[MUTED]");
}

function volumeIcon(string: String) {
    let muted = parseMuted(string);

    if(muted) {
        return "";
    }

    let icon = "";
    if(parseVolume(string) < 21) {
        icon = "";
    }
    
    return icon;
}

export function volumeTransform(state: Object) {
    let string = exec("wpctl get-volume @DEFAULT_AUDIO_SINK@");
    return `${volumeIcon(string)} ${parseVolume(string)}`;
}

