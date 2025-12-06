#!/bin/bash

#completeness check part1: BUSCO

#Requirements:
#individual in- and output directories
#${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta

#Variables (set these individually)
SAMPLE="Mel1"
MEGAN_DIR="/path/to/02quality-assessment/02megan"
BUSCO_DIR="/path/to/02quality-assessment/03busco"

module load busco/v5.4.5

cd "${BUSCO_DIR}"

time busco --in "${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta" --mode genome --augustus --cpu 20 --auto-lineage --out "${BUSCO_DIR}/${SAMPLE}.hi-c_exFun_auto" > "${BUSCO_DIR}/${SAMPLE}.hi-c_exFun_auto.log" 2>&1
