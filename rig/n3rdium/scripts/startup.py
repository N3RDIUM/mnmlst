# Startup script
import sys, os
sys.path.append(os.path.dirname(__file__))

from circadian import start_daemon as start_circadian_daemon
import subprocess
import time

# Warmup
time.sleep(.1)

# Wallpaper
_ = os.system("swww clear 1d2021")

# Circadian
start_circadian_daemon()

# Ask displays to connect once
subprocess.call(["/home/n3rdium/scripts/vnc-reload-all"])

