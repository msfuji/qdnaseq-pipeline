# qdnaseq-pipeline
A pipeline for running QDNAseq on the SHIROKANE supercomputer.

## Log in to OS6
```
qlogin -l os6
```

## Install QDNAseq into R ver. 3.6.0
```
/usr/local/package/r/3.6.0/bin/R
> if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
> BiocManager::install("QDNAseq")
> q()
```

## Download pipeline
```
git clone https://github.com/msfuji/qdnaseq-pipeline.git
cd qdnaseq-pipeline
```

## Run pipeline.
Among sections of config file, only [bam_import] and [mutation_call] will be interpreted.
```
/usr/local/package/python2.7/2.7.2/bin/python qdnaseq-pipeline.py <genomon_sample_conf.csv>
```
