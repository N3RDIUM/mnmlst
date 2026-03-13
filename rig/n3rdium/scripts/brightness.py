from monitor import Monitor
import os

def set_brightness(value: int, monitor: Monitor):
    match monitor:
        case Monitor.LEFT:
            pass # TODO
        case monitor.CENTRE:
            os.system(f"ddcutil setvcp 10 {value}")
        case Monitor.RIGHT:
            os.system(f"curl -X POST http://n3rdium-lite.local:8001/set-brightness/{value}")

