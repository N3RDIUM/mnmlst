import os
from monitor import Monitor

def set_temperature(value: int, monitor: Monitor):
    match monitor:
        case Monitor.LEFT:
            os.system(f"curl -X POST http://n3rdium-lap.local:8001/set-temperature/{value}")
        case Monitor.CENTRE:
            os.system(f"hyprctl hyprsunset temperature {value}")
        case Monitor.RIGHT:
            os.system(f"curl -X POST http://n3rdium-lite.local:8001/set-temperature/{value}")

