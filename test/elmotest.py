#!/usr/bin/env python

# Start power model test

from array import *
from subprocess import call

instructionpoint = 6

# 1. Run the executable runtime.bin

call(['.././elmo', 'RunTime/runtime.bin'])

# 2. Compare output against matlab generated

fp_testvectors = open('powermodeltestvectors.txt','r')
testvectors = float(fp_testvectors.readline())
fp_testvectors.close()

print testvectors
#print fp_testvectors.read()

a = array('d')

for i in range(1, 2):
    trace = 'output/traces/trace%05d' % i
    trace += '.trc'
    fp_elmo = open(trace, 'r')
    a.append(float(fp_elmo.readlines()[instructionpoint]))
    fp_elmo.close()

print a[0]
