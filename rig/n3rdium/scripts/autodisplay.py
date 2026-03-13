from http.server import BaseHTTPRequestHandler, HTTPServer
from brightness import set_brightness
from temperature import set_temperature
from monitor import Monitor

set_brightness(0, Monitor.CENTRE)

def set_all_temperatures(value: int):
    print("center")
    try:
        set_temperature(value, Monitor.CENTRE)
    except Exception as e:
        print(f"centre: {e}")

    print("right")
    try:
        set_temperature(value, Monitor.RIGHT)
    except Exception as e:
        print(f"right: {e}")

    print("left")
    try:
        set_temperature(value, Monitor.LEFT)
    except Exception as e:
        print(f"left: {e}")

def very_dark_setting():
    print("VERY DARK")

    set_brightness(0, Monitor.CENTRE)
    set_all_temperatures(1000)

def dark_setting():
    print("DARK")
    set_brightness(0, Monitor.CENTRE)
    set_all_temperatures(3000)

def bright_setting():
    print("BRIGHT")
    set_all_temperatures(6000)


samples = []

class LDRHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path.startswith("/ldr/"):
            try:
                value = int(self.path.split("/ldr/")[1])

                samples.append(value)
                if len(samples) > 3:
                    samples.pop(0)
                smooth = sum(samples) / len(samples)

                print(f"LDR value received: {value} smooth: {smooth}")

                if smooth < 42:
                    very_dark_setting()
                elif smooth < 100:
                    dark_setting()
                else: 
                    bright_setting()

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
