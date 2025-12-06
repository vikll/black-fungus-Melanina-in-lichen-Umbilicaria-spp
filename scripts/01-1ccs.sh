#!/bin/bash

#ccs calling, more sensitive setting

#Requirements:
#individual in- and output directories
#rawdata.subreads.bam file in RAW_DIR

#Variables (set these individually)
SAMPLE_0="rawdata"										#input ccs filename (from rawdata)
RAW_DIR="/path/to/rawdata"
CCS_DIR="/path/to/01ccs"

module load ccs/6.4.0

cd "${CCS_DIR}"

ccs -j 20 --top-passes 20 --min-passes 4 --min-snr 3.75 --min-rq 0.995 --log-level INFO --log-file "${CCS_DIR}/ccs_${SAMPLE_0}.log" "${RAW_DIR}/${SAMPLE_0}.subreads.bam" "${CCS_DIR}/${SAMPLE_0}.ccs.bam"
