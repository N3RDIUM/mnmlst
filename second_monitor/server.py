import sys, os
sys.stdout = open("/home/n3rdium/server.log", "w")
sys.stderr = open("/home/n3rdium/server.log", "w")

from flask import Flask, jsonify
import subprocess
import threading

app = Flask(__name__)

vnc_process = None
process_lock = threading.Lock()

# Replace this with your actual command
VNC_COMMAND = ["vncviewer", "192.168.1.42:5900", "--FullScreen", "--RemoteResize=off"]

@app.route("/reconnect-vnc/", methods=["POST", "GET"])
def reconnect_vnc():
    global vnc_process

    with process_lock:
        if vnc_process and vnc_process.poll() is None:
            vnc_process.terminate()
            try:
                vnc_process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                vnc_process.kill()

        vnc_process = subprocess.Popen(
            VNC_COMMAND,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )

    return jsonify({"status": "restarted"})

@app.route("/kitty/", methods=["POST", "GET"])
def kitty():
    try:
        os.system("kitty")
        return jsonify({"status": "ok"})
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

@app.route("/set-temperature/<int:temp>", methods=["POST", "GET"])
def set_temperature(temp):
    try:
        subprocess.run(
            ["hyprctl", "hyprsunset", "temperature", str(temp)],
            check=True,
        )
        return jsonify({"status": "ok", "temperature": temp})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "message": str(e)}), 500

@app.route("/reset-temperature/", methods=["POST", "GET"])
def reset_temperature():
    try:
        subprocess.run(
            ["hyprctl", "hyprsunset", "identity"],
            check=True,
        )
        return jsonify({"status": "ok"})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "message": str(e)}), 500

@app.route("/set-brightness/<int:brightness>", methods=["POST", "GET"])
def set_brightness(brightness):
    try:
        subprocess.run(
            ["xbacklight", "-set", str(brightness)],
            check=True,
        )
        return jsonify({"status": "ok", "brightness": brightness})
    except subprocess.CalledProcessError as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8001)

