#!/bin/bash

#demultiplexing
#last step must be adjusted manually -> copy the correct lima output for the following workflow

#Requirements:
#individual in- and output directories
#barcodes.fasta with demultiplexing barcodes (individual)
#ccs output file = ${CCS_DIR}/${SAMPLE_0}.ccs.bam

#Variables (set these individually)
SAMPLE_0="rawdata"										#input ccs filename (from rawdata)
SAMPLE="Mel1"											#sample name for all final output files
CCS_DIR="/path/to/01ccs"
BARCODES_DIR="/path/to/barcodes"
DEMULTI_DIR="/path/to/02demultiplexing"					#lima will create subfolders here -> these need to be checked manually to choose the right ouput file

module load lima/2.7.1

cd "${DEMULTI_DIR}"

time lima --num-threads 48 --split-named --split-subdirs --same --log-level INFO --log-file "${DEMULTI_DIR}/lima_preset_${SAMPLE_0}.log" --ccs --min-end-score 80 --min-ref-span 0.75 --single-end "${CCS_DIR}/${SAMPLE_0}.ccs.bam" "${BARCODES_DIR}/barcodes.fasta" "${DEMULTI_DIR}/${SAMPLE}.preset.demulti.bam"

##check output and copy SAMPLE into DEMULTI_DIR
#cp <lima_output_folder>/<desired_lima_output_file>.bam "${DEMULTI_DIR}/${SAMPLE}.demulti.bam"
