import sys
import os
sys.path.append(os.path.dirname(__file__))

from http.server import BaseHTTPRequestHandler, HTTPServer
from enum import Enum

from brightness import set_brightness
from temperature import set_temperature
from monitor import Monitor

set_brightness(0, Monitor.CENTRE)


class Setting(Enum):
    VDARK = 0
    DARK = 1
    LIGHT = 2

current = None

def set_all_temperatures(value: int):
    try:
        set_temperature(value, Monitor.CENTRE)
    except Exception as e:
        print(f"centre: {e}")

    try:
        set_temperature(value, Monitor.RIGHT)
    except Exception as e:
        print(f"right: {e}")

    try:
        set_temperature(value, Monitor.LEFT)
    except Exception as e:
        print(f"left: {e}")

def update_setting():
    global current
    set_brightness(0, Monitor.CENTRE)

    match current:
        case Setting.VDARK:
            set_all_temperatures(1000)
        case Setting.DARK:
            set_all_temperatures(3000)
        case Setting.LIGHT:
            set_all_temperatures(6000)
        case None:
            return

samples = []

class LDRHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        global current

        if self.path.startswith("/ldr/"):
            try:
                value = int(self.path.split("/ldr/")[1])

                samples.append(value)
                if len(samples) > 3:
                    samples.pop(0)
                smooth = sum(samples) / len(samples)
                # TODO do this^ on the board itself

                print(f"LDR value received: {value} smooth: {smooth}")

                prev = current

                if smooth < 28:
                    current = Setting.VDARK
                elif smooth < 100:
                    current = Setting.DARK
                else: 
                    current = Setting.LIGHT

                if prev != current:
                    print(f"updating {prev} -> {current}")
                    update_setting()

                self.send_response(200)
                self.send_header("Content-type", "text/plain")
                self.end_headers()
                self.wfile.write(b"OK")

            except Exception as e:
                print("Error:", e)
                self.send_response(400)
                self.end_headers()
        else:
            self.send_response(404)
            self.end_headers()


def run(server_class=HTTPServer, handler_class=LDRHandler, port=8001):
    server_address = ("", port)
    httpd = server_class(server_address, handler_class)
    print(f"Server running on port {port}")
    httpd.serve_forever()


if __name__ == "__main__":
    run()
