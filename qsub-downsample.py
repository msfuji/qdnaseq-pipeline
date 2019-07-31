#!/usr/bin/env python

import sys
import subprocess

args = sys.argv
inbam = args[1]
flagstat_file = args[2]
outbam = args[3]

mapq = 30

def get_read_num(file):
    with open(file) as f:
        rn = next(f).split(" ")[0]
        rn = int(rn)
    return(rn)

current_read_num = get_read_num(flagstat_file)

rand_seed = 123
intended_read_num = 2.0 * 10**7
frac = intended_read_num / current_read_num 
frac = rand_seed + frac
samtools="/usr/local/package/samtools/1.9/bin/samtools"

command = ("%s view -h -q %d -F 3844 %s | %s view -s %.4f -bo %s" %
           (samtools, mapq, inbam, samtools, frac, outbam))
print command
subprocess.call(command, shell=True)
