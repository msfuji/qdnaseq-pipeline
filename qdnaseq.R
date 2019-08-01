#
# R script for applying QDNASeq on low-depth WGS BAM
#
# Masashi Fujita (m-fujita@riken.jp), Dec. 19, 2018
#
# To run this script, "QDNAseq" package is required.
# In addition, "QDNAseq.hg19" package is also recommended.
#
# Usage: Rscript qdnaseq.R <tumor sample ID> <tumor BAM> \
#          <normal sample ID > <normal BAM> <output dir>
#

library(QDNAseq)

#
# parse command args
#
args <- commandArgs(trailingOnly=T)
tumor_id <- args[1]
tumor_bam <- args[2]
normal_id <- args[3]
normal_bam <- args[4]
outdir <- args[5]




bins <- getBinAnnotations(binSize=15)


readCounts <- binReadCounts(bins, bamfiles=c(tumor_bam, normal_bam),
                            ext="downsampled.bam")
readCountsFiltered <- applyFilters(readCounts)
readCountsFiltered <- estimateCorrection(readCountsFiltered)
copyNumbers <- correctBins(readCountsFiltered)
copyNumbersNormalized <- normalizeBins(copyNumbers)
copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)

#
# subtract the normal signal from tumor
#
tumorVsNormal <- compareToReference(copyNumbersSmooth, c(2, FALSE))

#
# CN segmentation
#
copyNumbersSegmented <- segmentBins(tumorVsNormal, transformFun="sqrt")
copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)

#
# CN call
#
copyNumbersCalled <- callBins(copyNumbersSegmented)

#
# go to output dir
#
cwd <- getwd()
setwd(outdir)

#
# export segments
#
file <- paste0(tumor_id, ".tmp.tsv")
exportBins(copyNumbersSegmented, file=file, type="segments")
png(sprintf("%s.segments.png", tumor_id))
plot(copyNumbersSegmented)
dev.off()

#
# export CN calls
#
exportBins(copyNumbersCalled, type="calls", format="vcf")
png(sprintf("%s.calls.png", tumor_id))
plot(copyNumbersCalled)
dev.off()

setwd(cwd)
