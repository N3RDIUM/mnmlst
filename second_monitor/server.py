import os

import flask
# use port 8001 for the flask thing

def connect_vnc():
    os.system('wlvncc 192.168.1.42 5900')

connect_vnc()

