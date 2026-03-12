# Startup manager for mnmlst

import sys, os
sys.path.append(os.path.dirname(__file__))

from circadian import start_daemon as start_circadian_daemon
import subprocess
import time
import signal
import atexit

# Store all daemon processes
daemons = []

# Second monitor
headless_output = subprocess.call(["hyprctl", "output", "create", "headless", "NOTHING-R"])
headless_output = subprocess.call(["hyprctl", "output", "create", "headless", "NOTHING-L"])
wayvnc = subprocess.Popen(["wayvnc", "-f", "60", "-o", "NOTHING-R", "-d", "-R", "0.0.0.0", "5900", "-p", "--gpu", "-S", "/tmp/wayvnc-r.sock"])
wayvnc = subprocess.Popen(["wayvnc", "-f", "60", "-o", "NOTHING-L", "-d", "-R", "0.0.0.0", "5901", "-p", "--gpu", "-S", "/tmp/wayvnc-l.sock"])
daemons.append(wayvnc)

# Circadian
hyprsunset = subprocess.Popen(["hyprsunset"])
daemons.append(hyprsunset)
time.sleep(.1)
start_circadian_daemon()

# Wallpaper
swww_daemon = subprocess.Popen(["swww-daemon", "--no-cache"])
daemons.append(swww_daemon)
for i in range(4):
    try:
        _ = subprocess.run(["swww", "clear", "1d2021"], check=True)
        continue
    except subprocess.CalledProcessError as e:
        print(f"Try {i}: could not set wallpaper: {e}")
    time.sleep(0.1)

# Ollama
ollama = subprocess.Popen(["ollama", "serve"])
daemons.append(ollama)

# FCITX5
fcitx = subprocess.Popen(["fcitx5", "-d", "-r"])
daemons.append(fcitx)
fcitx_remote = subprocess.Popen(["fcitx5-remote", "-r"])
daemons.append(fcitx_remote)

def cleanup_daemons():
    print("Cleaning up daemons...")
    for daemon in daemons:
        if daemon.poll() is None:  # Process is still running
            daemon.kill()
            daemon.wait()

# Register cleanup function
atexit.register(cleanup_daemons)

def signal_handler(signum, frame):
    cleanup_daemons()
    sys.exit(0)

# Register signal handlers
signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

# Ask displays to connect
subprocess.call(["/home/n3rdium/scripts/vnc-reload-all"])

