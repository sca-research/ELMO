import numpy as np
from picosdk.ps5000a import ps5000a as ps
from picosdk.constants import PICO_STATUS, PICO_STATUS_LOOKUP
from picosdk.errors import PicoSDKCtypesError
from picosdk.functions import mV2adc
import TRS_TraceSet
import random
import serial
import time
import ctypes
import secrets
# Print Hex Data
def PrintHexData(data):
    pdata = bytearray(data)
    rwdstr = pdata.hex().upper()
    # Insert spaces for between each 16-bits.
    dstr = ''
    i = 0
    while i in range(len(rwdstr)):
        dstr += rwdstr[i:i + 4] + ' '
        i += 4
    print(dstr)
    return
class BuildModel_M3_Single(object):
    if __name__ == "__main__":
        # Serial port communication: look this up in 'device manager'
        port = '/dev/ttyUSB0'  # Serial port
        step=1000
        # Number of traces
        N = 5000*23
        # Number of samples
        samples = 1000
        # 2ns, sampling rate= 500MSa/s(p22 2.7 Timebase)
        timebase = 1
        # post-trigger or before-trigger
        post_trigger = True
        # trigger threshold(mV)
        threshold = 2000
        # trigger direction
        posedge_trigger = True
        # vertical offset
        vertical_offset = 0.1
        #delay
        delay=0
        plain_len = 32  # byte length of the plaintext
        cipher_len = 32  # byte length of the ciphertext

        # Intiliazed random generator
        random.seed()
        # Open serial port
        ser = serial.Serial(port)
        # Wait for 200ms
        time.sleep(0.2)
        if (post_trigger):
            preTriggerSamples = 0
            postTriggerSamples = samples
        else:
            preTriggerSamples = samples
            postTriggerSamples = 0

            # Connect the scope
        chandle = ctypes.c_int16()
        status = ps.ps5000aOpenUnit(ctypes.byref(chandle), None, ps.PS5000A_DEVICE_RESOLUTION["PS5000A_DR_8BIT"])
        if status != PICO_STATUS['PICO_OK']:
            raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))
        # Set up channel A
        status = ps.ps5000aSetChannel(chandle, ps.PICO_CHANNEL["A"], 1, ps.PICO_COUPLING['DC'],
                                      ps.PS5000A_RANGE["PS5000A_1V"], vertical_offset)
        if status != PICO_STATUS['PICO_OK']:
            raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))
        # Set up channel B
        status = ps.ps5000aSetChannel(chandle, ps.PICO_CHANNEL["B"], 1, ps.PICO_COUPLING['DC'],
                                      ps.PS5000A_RANGE["PS5000A_5V"], 0)
        if status != PICO_STATUS['PICO_OK']:
            raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))
        # Set up trigger
        if (posedge_trigger):
            status = ps.ps5000aSetSimpleTrigger(chandle, 1, ps.PICO_CHANNEL["B"],
                                                mV2adc(threshold, ps.PS5000A_RANGE["PS5000A_5V"],
                                                       ctypes.c_int16(32512)), ps.PS5000A_THRESHOLD_DIRECTION["PS5000A_RISING"],
                                                delay,
                                                0)
        else:
            status = ps.ps5000aSetSimpleTrigger(chandle, 1, ps.PICO_CHANNEL["B"],
                                                mV2adc(threshold, ps.PS5000A_RANGE["PS5000A_5V"],
                                                       ctypes.c_int16(32512)),
                                                ps.PS5000A_THRESHOLD_DIRECTION["PS5000A_FALLING"],
                                                delay, 0)
        if status != PICO_STATUS['PICO_OK']:
            raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))

        # Create buffers ready for assigning pointers for data collection
        Databuffer = (ctypes.c_int16 * samples)()
        status = ps.ps5000aSetDataBuffers(chandle, 0, ctypes.byref(Databuffer), None, samples, 0, 0)
        if status != PICO_STATUS['PICO_OK']:
            raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))

        trs = TRS_TraceSet.TRS_TraceSet("BuildModel_M3_Single_1000Samples.trs")
        trs.write_header(N, samples, True, plain_len+cipher_len, 2E-9, 1 / 65536)
        for i in range(0, N):
            # Generate plaintext & mask
            plaintext = bytearray([secrets.randbits(8) for j in range(0, plain_len)])
            plaintext[28]=int(i/5000)+1
            # Start
            status = ps.ps5000aRunBlock(chandle, preTriggerSamples, postTriggerSamples, timebase, None, 0, None,
                                        None)
            if status != PICO_STATUS['PICO_OK']:
                raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))
            # Send plaintext
            ser.write(plaintext)
            # Read out ciphertext
            ciphertext = bytearray(ser.read(cipher_len))
            # Check for data collection to finish using ps5000aIsReady
            ready = ctypes.c_int16(0)
            check = ctypes.c_int16(0)
            while ready.value == check.value:
                status = ps.ps5000aIsReady(chandle, ctypes.byref(ready))
            # Create overflow location
            overflow = ctypes.c_int16()
            # create converted type totalSamples
            cTotalSamples = ctypes.c_int32(samples)
            # Retried data from scope to buffers assigned above
            status = ps.ps5000aGetValues(chandle, 0, ctypes.byref(cTotalSamples), 0, 0, 0, ctypes.byref(overflow))
            if status != PICO_STATUS['PICO_OK']:
                raise PicoSDKCtypesError("PicoSDK returned '{}'".format(PICO_STATUS_LOOKUP[status]))
            if (overflow.value != 0):
                print("overflow!")
            # Write trace
            trs.write_trace(plaintext, ciphertext,np.array(Databuffer), True)
            # print to screen
            if i % step == 0 and i > 0:
                print("i=" + str(i))
                print("Instr=" + str(plaintext[28]))
                print("plain=")
                PrintHexData(plaintext)
                print("cipher=")
                PrintHexData(ciphertext)
        trs.close()

