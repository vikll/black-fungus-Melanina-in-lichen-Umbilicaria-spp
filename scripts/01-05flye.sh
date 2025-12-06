#!/bin/bash

#run flye/2.9.1 assembler

#Requirements:
#individual in- and output directories
#converted output file in fastq format = ${BAM_CONVERT_DIR}/${SAMPLE}.hifi.fastq

#Variables (set these individually)
SAMPLE="Mel1"
BAM_CONVERT_DIR="/path/to/03bamtools/02bamtools_convert"
ASSEMBLY_DIR="/path/to/04assembly"

module load flye/2.9.1

cd "${ASSEMBLY_DIR}"

time flye -t 20 --no-alt-contigs --meta --pacbio-hifi "${BAM_CONVERT_DIR}/${SAMPLE}.hifi.fastq" --out-dir "${ASSEMBLY_DIR}/${SAMPLE}.flye" > "${ASSEMBLY_DIR}/${SAMPLE}.flye.log" 2>&1
