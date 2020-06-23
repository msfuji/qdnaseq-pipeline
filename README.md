# qdnaseq-pipeline
Pipeline for running QDNAseq on the SHIROKANE supercomputer.

## Install QDNAseq into R v3.6.0
Start R.
```
/usr/local/package/r/3.6.0/bin/R
```
Install required packages.
```
install.packages(c("dplyr", "data.table", "readr"))
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("impute")
BiocManager::install("marray")
install.packages("R.methodsS3")
BiocManager::install("QDNAseq")
BiocManager::install("QDNAseq.hg19")
```

## Download pipeline
```
git clone https://github.com/msfuji/qdnaseq-pipeline.git
cd qdnaseq-pipeline
```

## Run pipeline
Among sections of config file, only `[bam_import]` and `[mutation_call]` will be
interpreted.
```
/usr/local/package/python/2.7.15/bin/python2.7 qdnaseq-pipeline.py <genomon_sample_conf.csv>
```

## Output
The CNV call is stored in VCF files. CHROM, POS, and END show the coordinates of
CNV. ALT sholws the type of CNV (deletion or duplication).
SCORE represents double deletion (-2), single deletion (-1), gain (1), double
gain (2) and amplification (3).
