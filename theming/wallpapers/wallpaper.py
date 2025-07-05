import os
from datetime import datetime
from time import sleep
import subprocess

# Ensure single instance
try:
    with open(".wallsetter_lastpid") as f:
        pid = f.read()
    os.system(f"kill {pid}")
except FileNotFoundError:
    pass

with open(".wallsetter_lastpid", "w") as f:
    f.write(str(os.getpid()))


_ = subprocess.call("swww-daemon")

def set_wall(name):
    _ = os.system(
        f"swww img {os.path.join(os.path.dirname(__file__), name)}"
    )

while True:
    set_wall("classroom.jpg")

