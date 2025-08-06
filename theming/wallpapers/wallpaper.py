import os
import subprocess

_ = subprocess.call("swww-daemon")

def set_wall(name):
    _ = os.system(
        f"swww img {os.path.join(os.path.dirname(__file__), name)}"
    )

set_wall("cornell.png")

