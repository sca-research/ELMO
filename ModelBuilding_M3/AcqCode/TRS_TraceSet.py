# Si GAO Nov 27, 2017
# Write the measured trace to TRS file
import numpy             as np
import struct
import array
# Riscure TRS trace set file wrapper
class TRS_TraceSet(object):
    Number_of_Traces=0;
    index=0;#Trace index
    SC=0;
    def __init__(self,filename):
        self.f = open(filename, 'wb+')

    def __del__(self):
        self.f.close()

    #Write TRS file header
    def write_header(self,n,number_of_samples,isint,cryptolen,xscale,yscale):
        self.Number_of_Traces=n
        self.index = 0
        # Write Header Info
        # Tag   Len Discription
        # 0x41  4   Number of traces
        self.f.write(bytes(b'\x41\x04'))
        self.f.write(n.to_bytes(4, byteorder='little'))
        # 0x42  4   Number of samples per trace
        self.f.write(bytes(b'\x42\x04'))
        self.f.write(number_of_samples.to_bytes(4, byteorder='little'))
        # 0x43  1   Sample Coding
        self.f.write(bytes(b'\x43\x01'))
        if isint:
            self.f.write(bytes(b'\x02'))
            self.SC = 2
        else:
            self.f.write(bytes(b'\x14'))
            self.SC = 20
        # 0x44  2   Length of cryptographic data included in trace
        self.f.write(bytes(b'\x44\x02'))
        self.f.write(cryptolen.to_bytes(2, byteorder='little'))
        # 0x45  1   Title space reserved per t
        self.f.write(bytes(b'\x45\x01\x00'))
        # 0x4B  4   Scale value for X-axis
        self.f.write(bytes(b'\x4B\x04'))
        self.f.write(bytearray(struct.pack("f", xscale)))
        # 0x4C  4   Scale value for Y-axis
        self.f.write(bytes(b'\x4C\x04'))
        self.f.write(bytearray(struct.pack("f", yscale)))
        # 0x5F  1   End mark
        self.f.write(bytes(b'\x5F\x00'))
    # Write One Trace
    # crypto data: device input first, then device output
    def write_trace(self, plain: object, cipher: object, trc: object, enc: object) -> object:
        if enc: # performing encryption
            self.f.write(plain)
            self.f.write(cipher)
        else:  # performing decryption
            self.f.write(cipher)
            self.f.write(plain)
        # write trace
        
        if self.SC == 20:
           self.f.write(bytearray(struct.pack('f'*len(trc),*trc)))
        else:
           self.f.write(bytearray(struct.pack('h'*len(trc),*trc)))
    def flush(self):
        self.f.flush()
    def close(self):
        self.f.close();

if __name__ == "__main__":
  trs = TRS_TraceSet("TestTRS.trs")
  trs.write_header(987,1000,True,16,280E-9,1E-2)
  a = array.array('H', range(1000));
  trs.write_trace(bytearray(8),bytearray(8),a,True)
  del(trs)
