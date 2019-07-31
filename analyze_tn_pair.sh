#!/bin/bash
#$ -S /bin/bash

tumor_id=$1
tumor_bam=$2
normal_id=$3
normal_bam=$4
outdir=$5

mkdir -p $outdir

#
# count #reads
#
tumor_stat="${outdir}/${tumor_id}.flagstat"
normal_stat="${outdir}/${normal_id}.flagstat"
bash qsub-flagstat.sh $tumor_bam $tumor_stat
bash qsub-flagstat.sh $normal_bam $normal_stat

#
# downsample BAM
#
tumor_ds_bam="${outdir}/${tumor_id}.downsampled.bam"
normal_ds_bam="${outdir}/${normal_id}.downsampled.bam"
/usr/local/bin/python qsub-downsample.py $tumor_bam $tumor_stat $tumor_ds_bam
/usr/local/bin/python qsub-downsample.py $normal_bam $normal_stat $normal_ds_bam

#
# run qdnaseq
#
RSCRIPT="/usr/local/package/r/3.6.0/bin/Rscript"
$RSCRIPT qdnaseq.R $tumor_id $tumor_ds_bam $normal_id $tumor_ds_bam $outdir

#
# make GISTIC2 input
#
inseg="${outdir}/${tumor_id}.seg"
outseg="${outdir}/${tumor_id}.join.seg"
$RSCRIPT make-seg.R $tumor_id $inseg $outseg

