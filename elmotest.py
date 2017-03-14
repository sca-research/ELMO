#!/usr/bin/env python

# Start power model test

from array import *
from subprocess import call

instructionpoint = 8

# 1. Run the executable runtime.bin

call(['./elmo', 'test/RunTime/runtime.bin'])

# 2. Compare output against matlab generated data
