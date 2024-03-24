#!/usr/bin/env python

import sys
import os
import subprocess


def get_current_brightness():
    get_brightness_command = (
        "xrandr --verbose | awk '/Brightness/ { print $2 }'"
    )
    brightness = subprocess.check_output(
        get_brightness_command, shell=True, encoding="utf-8"
    )
    brightness = float(brightness)
    return brightness


def get_brightness_display():
    brightness = get_current_brightness()
    icon = "󰃝"
    if 2.08 >= brightness > 1.72:
        icon = "󰃠"
    elif 1.72 >= brightness > 1.36:
        icon = "󰃟"
    elif 1.36 >= brightness > 1:
        icon = "󰃞"
    elif 1 > brightness > 0.64:
        icon = "󰃜"
    elif 0.64 >= brightness > 0.28:
        icon = "󰃛"
    elif 0.28 >= brightness >= 0:
        icon = "󰃚"

    return f"{icon} %.2f" % brightness


def constrain_brightness(brightness):
    if brightness > 2.08:
        return 2.08
    elif brightness < 0.0:
        return 0.0

    return brightness


def adjust_brightness(argument):
    get_monitor_command = (
        "xrandr | grep -w connected  | awk -F'[ +]' '{print $1}'"
    )
    monitor = subprocess.check_output(
        get_monitor_command, shell=True, encoding="utf-8"
    ).strip()

    brightness = get_current_brightness()
    brightness = constrain_brightness(brightness)
    # print("%.15f" % brightness)

    if argument == "reset":
        brightness = 1
    if argument == "up":
        brightness += 0.06
        # print("%.15f" % brightness)
    elif argument == "down":
        brightness -= 0.06
        # print("%.15f" % brightness)

    try:
        xrandr_command = f"xrandr --output {monitor} --brightness {brightness}"
        exit_status = os.system(xrandr_command)
        if exit_status == 0:
            pass
            # print("Brightness adjusted successfully.")
        else:
            pass
            # print("Error changing brightness using 'xrandr'")
    except Exception as e:
        pass
        # print("Error adjusting brightness:", e)


arg = sys.argv[1]
if len(sys.argv) != 2 or arg not in ["up", "down", "reset", "get"]:
    # print("Usage: brightness [up/down/reset/get]")
    pass
else:
    if arg == "get":
        print(get_brightness_display())
    else:
        adjust_brightness(sys.argv[1])
        print(get_brightness_display())
