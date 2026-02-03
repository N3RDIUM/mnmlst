import time, json, os
from datetime import datetime, timedelta
import subprocess
from typing import Literal

def set_temperature(value: int | None = None, mode: Literal["left", "right", "both"] = "both") -> None:
    if not value:
        _ = subprocess.run(
            ["/home/n3rdium/scripts/distemp", mode, "reset"],
            check=True,
        )
        return

    if value < 1000:
        value = 1000
    elif value > 20000:
        value = 20000


    _ = subprocess.run(
        ["/home/n3rdium/scripts/distemp", mode, str(value)],
        check=True,
    )

def set_brightness(value: int = 0, mode: Literal["left", "right", "both"] = "both") -> None:
    if value < 0:
        value = 0
    elif value > 100:
        value = 100

    _ = subprocess.run(
        ["/home/n3rdium/scripts/disbright", mode, str(value)],
        check=True,
    )

with open("/home/n3rdium/.config/circadian.json", "r") as f:
    config = json.load(f)
brightness_schedule = config["brightness"]
temperature_schedule = config["temperature"]

def parse_time(hms: str) -> timedelta:
    h, m, s = map(int, hms.split(":"))
    return timedelta(hours=h, minutes=m, seconds=s)

def get_current_range(schedule):
    """Return start, end, and start/end values for current time."""
    now = timedelta(
        hours=datetime.now().hour,
        minutes=datetime.now().minute,
        seconds=datetime.now().second
    )

    times = sorted((parse_time(k) for k in schedule.keys()))
    for i, start in enumerate(times):
        end = times[i + 1] if i + 1 < len(times) else times[0] + timedelta(days=1)
        if start <= now < end or (i == len(times)-1 and now >= start):
            start_val = schedule[list(schedule.keys())[i]]
            end_val = schedule[list(schedule.keys())[(i + 1) % len(times)]]
            return start, end, start_val, end_val
    return None, None, None, None  # fallback (should not happen)

def interpolate(value_start, value_end, ratio):
    return int(value_start + (value_end - value_start) * ratio)

def mainloop():
    while True:
        if os.path.exists("/home/n3rdium/.config/.circadian-override"):
            continue
        # Brightness
        b_start, b_end, b_val_start, b_val_end = get_current_range(brightness_schedule)
        now = timedelta(
            hours=datetime.now().hour,
            minutes=datetime.now().minute,
            seconds=datetime.now().second
        )
        b_ratio = ((now - b_start).total_seconds() / (b_end - b_start).total_seconds())
        current_brightness = interpolate(b_val_start, b_val_end, b_ratio)
        set_brightness(current_brightness, mode="both")

        # Temperature
        t_start, t_end, t_val_start, t_val_end = get_current_range(temperature_schedule)
        t_ratio = ((now - t_start).total_seconds() / (t_end - t_start).total_seconds())
        current_temperature = interpolate(t_val_start, t_val_end, t_ratio)
        set_temperature(current_temperature, mode="both")

        print(current_brightness, current_temperature)
        time.sleep(5)

if __name__ == "__main__":
    mainloop()

