import os
from datetime import datetime
from time import sleep

# Ensure single instance
try:
    with open(".circadian_lastpid") as f:
        pid = f.read()
    os.system(f"kill {pid}")
except FileNotFoundError:
    pass

with open(".circadian_lastpid", "w") as f:
    f.write(str(os.getpid()))

def get_hour() -> int:
    return datetime.now().hour

# Mainloop
NONE = ("", "Default", " ")
WARM = ("~/.hyprshaders/warm.glsl", "Warm", "")
ASTRO = ("~/.hyprshaders/astro.glsl", "Astro", " ")

previous = None
current = NONE

while True:
    hour = get_hour()

    if hour >= 7 and hour <= 18:
        current = NONE
    elif (hour > 18 and hour < 21) or (hour > 4 and hour < 7):
        current = WARM
    else:
        current = ASTRO

    if current != previous:
        os.system(f"hyprctl keyword decoration:screen_shader \"{current[0]}\"")
        os.system(f"ags request \"osd circadian {current[1]} {current[2]}\"")
        previous = current

    sleep(20)

