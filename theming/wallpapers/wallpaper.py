import os
from datetime import datetime
from time import sleep
import subprocess

# Ensure single instance
try:
    with open(".circadian_lastpid") as f:
        pid = f.read()
    os.system(f"kill {pid}")
except FileNotFoundError:
    pass

with open(".circadian_lastpid", "w") as f:
    f.write(str(os.getpid()))


_ = subprocess.call("swww-daemon")

def get_hour() -> int:
    return datetime.now().hour

def set_wall(name):
    _ = os.system(
        f"swww img {os.path.join(os.path.dirname(__file__), name)}"
    )

DAY = "von.jpg"
NIGHT = "pxl.png"

previous = None
current = NIGHT

while True:
    hour = get_hour()

    if hour >= 6 and hour <= 18:
        current = DAY
    else:
        current = NIGHT

    if current != previous:
        set_wall(current)
        previous = current

    sleep(20)

