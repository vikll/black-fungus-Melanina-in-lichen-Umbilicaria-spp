#!/bin/bash

#filter for hifi reads

#Requirements:
#individual in- and output directories
#demultiplexed output file = ${DEMULTI_DIR}/${SAMPLE}.demulti.bam

#Variables (set these individually)
SAMPLE="Mel1"
DEMULTI_DIR="/path/to/02demultiplexing"
BAM_FILTER_DIR="/path/to/03bamtools/01bamtools_filter"

module load bamtools/2.5.2

cd "${BAM_FILTER_DIR}"

time bamtools filter -in "${DEMULTI_DIR}/${SAMPLE}.demulti.bam" -out "${BAM_FILTER_DIR}/${SAMPLE}.hifi.bam" -tag "rq":">=0.99"
