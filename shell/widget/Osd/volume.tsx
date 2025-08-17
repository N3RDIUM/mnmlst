import { createPoll } from "ags/time";

function parseVolume(string: String) {
    return Math.round(parseFloat(string.split(": ")[1].replace("%", "")) * 100)
}
function parseMuted(string: String) {
    return string.includes("[MUTED]");
}

const volume = createPoll(
    0,
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseVolume(out),
);
const muted = createPoll(
    false,
    100,
    "wpctl get-volume @DEFAULT_AUDIO_SINK@",
    (out, prev) => parseMuted(out),
);

function volumeIcon() {
    if(muted.get()) {
        return "";
    }

    let icon = "";
    if(volume.get() < 21) {
        icon = "";
    }
    
    return icon;
}

export function volumeTransform(state: Object) {
    return `${volumeIcon()} ${volume.get()}`;
}

