#!/bin/bash
#$ -S /bin/bash

inbam=$1
outfile=$2

mapq=30

samtools="/usr/local/package/samtools/1.9/bin/samtools"
command="$samtools view -h -q ${mapq} -F 3844 ${inbam} | $samtools flagstat - > ${outfile}"
echo $command
echo $command | /bin/bash
