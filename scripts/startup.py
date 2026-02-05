# Startup manager for mnmlst

import sys, os
sys.path.append(os.path.dirname(__file__))

from circadian import start_daemon as start_circadian_daemon
import subprocess
import time
import signal
import atexit
import fcntl

def ensure_single_instance_or_replace(lock_path="/tmp/my_script.lock"):
    lock_file = open(lock_path, "a+")

    try:
        # Try locking first
        fcntl.flock(lock_file, fcntl.LOCK_EX | fcntl.LOCK_NB)

    except BlockingIOError:
        # Someone else holds the lock — read PID
        lock_file.seek(0)
        pid_str = lock_file.read().strip()

        if pid_str.isdigit():
            old_pid = int(pid_str)

            try:
                # Check if process exists
                os.kill(old_pid, 0)

                # Kill it gracefully first
                os.kill(old_pid, signal.SIGTERM)

                # Wait briefly
                for _ in range(20):
                    try:
                        os.kill(old_pid, 0)
                        time.sleep(0.1)
                    except OSError:
                        break
                else:
                    # Still alive → force kill
                    os.kill(old_pid, signal.SIGKILL)

            except OSError:
                # Process already dead
                pass

        # Now block until lock becomes available
        fcntl.flock(lock_file, fcntl.LOCK_EX)

    # We now own the lock
    lock_file.seek(0)
    lock_file.truncate()
    lock_file.write(str(os.getpid()))
    lock_file.flush()

    return lock_file

ensure_single_instance_or_replace()

# Store all daemon processes
daemons = []

# Second monitor
headless_output = subprocess.call(["hyprctl", "output", "create", "headless", "NOTHING"])
wayvnc = subprocess.Popen(["wayvnc", "-f", "60", "-o", "NOTHING", "-d", "-R", "0.0.0.0", "5900"])
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

def get_wayvnc_client_count() -> int:
    try:
        result = subprocess.run(
            ["wayvncctl", "client-list"],
            capture_output=True,
            text=True,
            check=True,
        )

        # Example lines:
        # "  1: 192.168.1.37"
        # Count only lines that look like clients.
        clients = [
            line for line in result.stdout.splitlines()
            if line.strip() and ":" in line
        ]

        return len(clients)

    except subprocess.CalledProcessError:
        return 0
    except FileNotFoundError:
        return 0

while True:
    if get_wayvnc_client_count() < 1:
        subprocess.call(["/home/n3rdium/scripts/second-reload"])

    # TODO restart daemons if killed

    time.sleep(4)

