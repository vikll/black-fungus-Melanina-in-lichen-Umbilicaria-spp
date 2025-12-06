#!/bin/bash

#contamination check with fcs

#Requirements:
#individual in- and output directories
#${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta
#fcs database -> ${FCS_DIR}/fcs-gx_2023-01-19 (individual)

#Variables (set these individually)
SAMPLE="Mel1"
ASSEMBLY_RES_DIR="/path/to/final-hic-assembly-directory" 
FCS_DIR="/path/to/02quality-assessment/06fcs"
GX_DB="${FCS_DIR}/fcs-gx_2023-01-19"

module load fcs/0.5.0

cd "${FCS_DIR}"

time fcsadaptor --fasta-input "${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta" --output-dir "${FCS_DIR}/out_${SAMPLE}-hic-fcsadaptor" --euk

time fcs screen genome --fasta "${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta" --out-dir "${FCS_DIR}/gx_out/" --gx-db "${GX_DB}/all" --tax-id 2806501