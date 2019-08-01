# qdnaseq-pipeline
Pipeline for running QDNAseq on the SHIROKANE supercomputer.

## Log in to OS6
```
qlogin -l os6
```

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
BiocManager::install("QDNAseq")
BiocManager::install("QDNAseq.hg19")
```

## Download pipeline
```
git clone https://github.com/msfuji/qdnaseq-pipeline.git
cd qdnaseq-pipeline
```

## Run pipeline
Among sections of config file, only `[bam_import]` and `[mutation_call]` will be interpreted.
```
/usr/local/package/python2.7/2.7.2/bin/python qdnaseq-pipeline.py <genomon_sample_conf.csv>
```
