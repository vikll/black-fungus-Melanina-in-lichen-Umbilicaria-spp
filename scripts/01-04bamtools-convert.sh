#!/bin/bash

#convert hifi reads to fastq format for flye/2.9.1 assembler

#Requirements:
#individual in- and output directories
#filtered output file = ${BAM_FILTER_DIR}/${SAMPLE}.hifi.bam

#Variables (set these individually)
SAMPLE="Mel1"
BAM_FILTER_DIR="/path/to/03bamtools/01bamtools_filter"
BAM_CONVERT_DIR="/path/to/03bamtools/02bamtools_convert"

module load bamtools/2.5.2

cd "${BAM_CONVERT_DIR}"

time bamtools convert -format fastq -in "${BAM_FILTER_DIR}/${SAMPLE}.hifi.bam" -out "${BAM_CONVERT_DIR}/${SAMPLE}.hifi.fastq"
