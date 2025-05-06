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
while True:
    hour = get_hour()

    if hour >= 8 and hour <= 18:
        os.system("hyprctl keyword decoration:screen_shader \"\"")
    elif (hour > 18 and hour < 21) or (hour > 4 and hour < 8):
        os.system("hyprctl keyword decoration:screen_shader \"~/.hyprshaders/warm.glsl\"")
    else:
        os.system("hyprctl keyword decoration:screen_shader \"~/.hyprshaders/astro.glsl\"")

    sleep(20)

