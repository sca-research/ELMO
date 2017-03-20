#!/usr/bin/env python

# Start power model test

from array import *
from subprocess import call
from decimal import Decimal, ROUND_DOWN

powermodeltest = 0
functest = 0
fixedvsrandomtest = 0

print '#####################################################'

try:
    raw_input('\nWARNING: before running test script elmo must be compiled to include "test/elmodefinestest.h" rather than "elmodefines.h"\n\nPress enter to continue.\n')
except SyntaxError:
    pass

print '#####################################################'



instructionpoint = 7

# 1. Run the executable runtime.bin

call(['.././elmo', 'elmotestbinaries/powermodeltest/runtime.bin'])

# 2. Compare output against matlab generated

fp_testvectors = open('powermodeltestvectors.txt','r')

#print fp_testvectors.read()

print 'STARTING POWER MODEL TEST...'

a = array('d')
count = 1
passnumber = 0
failnumber = 0

for i in range(0, 5):
    for j in range(0, 5):
        for k in range(0, 5):
            for repeatnumber in range(0, 1000):
                trace = 'output/traces/trace%05d' % count
                trace += '.trc'
                fp_elmo = open(trace, 'r')
                elmopower = float(fp_elmo.readlines()[instructionpoint])
                testvector = float(fp_testvectors.readline())
                # Test to 12 decimal places
                result = Decimal(elmopower).quantize(Decimal('.000000000001')) - Decimal(testvector).quantize(Decimal('.000000000001'))
                if(result == 0):
                    passnumber = passnumber + 1
                else:
                    failnumber = failnumber + 1
                    print 'FAIL: ', i, j, k, repeatnumber, result
                count = count + 1
                fp_elmo.close()

fp_testvectors.close()

print 'PASS: ', passnumber
print 'FAIL: ', failnumber

print '#####################################################'

if(failnumber>0):
    print 'POWERMODEL TEST: FAIL'
else:
    print 'POWERMODEL TEST: PASS'
    powermodeltest = 1

print '#####################################################'

# Fixed vs Random test
print 'STARTING FIXED VS RANDOM TEST...'

call(['.././elmo', 'elmotestbinaries/fixedvsrandom/MBedAES/MBedAES.bin'])

# Test output is correct
fp_AESvectors = open('AEStestvectors.txt','r')
fp_AESelmooutput = open('output/traces/uartout.txt','r')

passnumber = 0
failnumber = 0

# Clear fixed traces
for i in range(0, (5000*16)):
    elmooutput = int(fp_AESelmooutput.readline(), 16)

for i in range(0, (5000*16)):

    testvector = int(fp_AESvectors.readline(), 16)
    elmooutput = int(fp_AESelmooutput.readline(), 16)

    result = testvector - elmooutput
    
    if(result == 0):
        passnumber = passnumber + 1
    else:
        failnumber = failnumber + 1
        print 'FAIL: ', i

fp_AESelmooutput.close()
fp_AESvectors.close()

print 'PASS: ', passnumber
print 'FAIL: ', failnumber

print '#####################################################'

if(failnumber>0):
    print 'AES FUNC TEST: FAIL'
else:
    print 'AES FUNC TEST: PASS'
    functest = 1

print '#####################################################'

# Check T-test is correct
fp_fixedvsrandomvectors = open('fixedvsrandomtestvectors.txt','r')
fp_fixedvsrandomelmo = open('output/fixedvsrandomfail.txt','r')

passnumber = 0
failnumber = 0
i = 0;

with open('fixedvsrandomvectors.txt') as openfileobject:
    for line in openfileobject:
    
        testvector = float(fp_fixedvsrandomvectors.readline())
        elmooutput = float(fp_fixedvsrandomelmo.readline())
        
        result = Decimal(testvector).quantize(Decimal('.001')) - Decimal(elmooutput).quantize(Decimal('.001'))
        
        if(result == 0):
            passnumber = passnumber + 1
        else:
            failnumber = failnumber + 1
            print 'FAIL: ', i

        i = i + 1;

fp_fixedvsrandomvectors.close()
fp_fixedvsrandomelmo.close()

print 'PASS: ', passnumber
print 'FAIL: ', failnumber


print '#####################################################'

if(failnumber>0):
    print 'FIXED VS RANDOM TEST: FAIL'
else:
    print 'FIXED VS RANDOM TEST: PASS'
    fixedvsrandomtest = 1

print '#####################################################'

print 'SUMMARY'

print '#####################################################'

print('POWER MODEL TEST')
if(powermodeltest):
    print 'PASS'
else:
    print 'FAIL'

print('FUNC TEST')
if(functest):
    print 'PASS'
else:
    print 'FAIL'

print('FIXED VS RANDOM TEST')
if(fixedvsrandomtest):
    print 'PASS'
else:
    print 'FAIL'

print '#####################################################'
