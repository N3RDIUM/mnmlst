import math
import time
import datetime

SVG_WIDTH = 200
SVG_HEIGHT = 200
CENTER_X = SVG_WIDTH / 2
CENTER_Y = SVG_HEIGHT / 2

HOUR_LENGTH = 50
MINUTE_LENGTH = 70
SECOND_LENGTH = 90

def polar_to_cartesian(length, angle_deg):
    angle_rad = math.radians(angle_deg - 90)
    x = CENTER_X + length * math.cos(angle_rad)
    y = CENTER_Y + length * math.sin(angle_rad)
    return x, y

def get_hand_angles(now):
    second_angle = now.second * 6
    minute_angle = now.minute * 6 + now.second * 0.1
    hour_angle = (now.hour % 12) * 30 + now.minute * 0.5
    return hour_angle, minute_angle, second_angle

def create_hand(x2, y2, color, width):
    return f'<line x1="{CENTER_X}" y1="{CENTER_Y}" x2="{x2}" y2="{y2}" stroke="{color}" stroke-width="{width}" stroke-linecap="round" />'

def generate_clock_svg():
    now = datetime.datetime.now()
    hour_angle, minute_angle, second_angle = get_hand_angles(now)

    hour_x, hour_y = polar_to_cartesian(HOUR_LENGTH, hour_angle)
    minute_x, minute_y = polar_to_cartesian(MINUTE_LENGTH, minute_angle)
    second_x, second_y = polar_to_cartesian(SECOND_LENGTH, second_angle)

    svg = f'''<svg xmlns="http://www.w3.org/2000/svg" width="{SVG_WIDTH}" height="{SVG_HEIGHT}" viewBox="0 0 {SVG_WIDTH} {SVG_HEIGHT}">
    <circle cx="{CENTER_X}" cy="{CENTER_Y}" r="{min(CENTER_X, CENTER_Y) - 1}" fill="#504945" stroke-width="0" />,
    {create_hand(second_x, second_y, '#fb4934', 1)}
    {create_hand(minute_x, minute_y, '#ebdbb2', 2)}
    {create_hand(hour_x, hour_y, '#ebdbb2', 4)}
</svg>'''
    return svg

while True:
    time.sleep(1)
    svg_content = generate_clock_svg()
    with open("/home/n3rdium/.clock.svg", "w") as f:
        f.write(svg_content)

