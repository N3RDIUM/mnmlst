# Simple script to control table lamp
# Also sends the LDR value to the main rig

from machine import ADC, Pin, PWM
import time    
import urequests as request

ldr = ADC(0)
lamp = PWM(Pin(5))
lamp.freq(1000)

lamp_on = False

def fade_in():
    global lamp_on
    if lamp_on: return
    for i in range(1024):
        lamp.duty(i)
        time.sleep(1/512)
    lamp_on = True
    
def fade_out():
    global lamp_on
    if not lamp_on: return
    for i in range(1024):
        lamp.duty(1023 - i)
        time.sleep(1/747)
    lamp_on = False

def fade_lamp(ldr: int):
    if ldr < 128:
        fade_in()
        return
    fade_out()

while True:
    value = ldr.read()
    
    try:
        print("LDR Value:", value)
        response = request.get(f"http://192.168.1.42:8001/ldr/{value}")
        print(response.text)
    except KeyboardInterrupt:
        break
    except Exception as e:
        print(f"request failed: {e}")
    finally:
        fade_lamp(value)
        time.sleep(1/10)

