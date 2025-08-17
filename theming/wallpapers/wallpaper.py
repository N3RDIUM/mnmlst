import os
import subprocess

_ = subprocess.call("swww-daemon")

def set_wall(name):
    _ = os.system(
        f"swww img {os.path.join(os.path.dirname(__file__), name)}"
    )

# Why a python script for this?
# Well, a lot can be done this way.
# A lot that I might require one day.
# And I might be too lazy to set this up,
# on that particular day. That's why.
set_wall("current.png")

