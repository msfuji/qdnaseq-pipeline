#!/usr/bin/env python

import os
import sys
import sample_conf
import subprocess

conf_file = sys.argv[1]
conf = sample_conf.Sample_conf()
conf.parse_file(conf_file)

def analyze_tn_pair(tumor_id, tumor_bam, normal_id, normal_bam):
    outdir="output/%s" % tumor_id
    command = "qsub -l os6 -cwd -j y -o log analyze_tn_pair.sh %s %s %s %s %s" \
              % (tumor_id, tumor_bam, normal_id, normal_bam, outdir)
    print command
    subprocess.call(command, shell=True)


os.mkdir("log")
os.mkdir("output")
for tumor_id, normal_id, _ in conf.mutation_call:
    tumor_bam = conf.bam_import[tumor_id]
    normal_bam = conf.bam_import[normal_id]
    analyze_tn_pair(tumor_id, tumor_bam, normal_id, normal_bam)

