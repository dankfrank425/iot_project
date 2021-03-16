#!/usr/bin/env python3

import json
import sys
import smbus2
import bme280

port = 1
def_addr = 0x77
bus = smbus2.SMBus(port)

def get_values(address=def_addr):
    calibration_params = bme280.load_calibration_params(bus, address)
    data = bme280.sample(bus, address, calibration_params)

    d = {
        "temperature": float("{:.3f}".format(data.temperature)),
        "humidity": float("{:.3f}".format(data.humidity)),
        "pressure": float("{:.3f}".format(data.pressure))
    }

    if len(sys.argv) >= 3:
        d["location"] = sys.argv[2]

    return json.dumps(d)


if len(sys.argv) >= 2:
    if sys.argv[1] == '76':
        print(get_values(0x76))
    if sys.argv[1] == '77':
        print(get_values(0x77))
else:
    print(get_values())
