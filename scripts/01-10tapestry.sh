#!/bin/bash

#completeness check part2: tapestry
#uncomment last copy command after manual curation

#Requirements:
#individual in- and output directories
#${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta
#${BAM_CONVERT_DIR}/${SAMPLE}.hifi.fastq

#Variables (set these individually)
SAMPLE="Mel1"
MEGAN_DIR="/path/to/02quality-assessment/02megan"
BAM_CONVERT_DIR="/path/to/03bamtools/02bamtools_convert"
TAPESTRY_DIR="/path/to/02quality-assessment/04tapestry"
ASSEMBLY_RES_DIR="/path/to/final-hic-assembly-directory"

module load tapestry/1.0.1

cd "${TAPESTRY_DIR}"

ln -s "${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta" .
gzip -c "${BAM_CONVERT_DIR}/${SAMPLE}.hifi.fastq" > "${TAPESTRY_DIR}/${SAMPLE}.hifi.fastq.gz"

time weave -a "${SAMPLE}.hi-c_exFungi.fasta" -r "${SAMPLE}.hifi.fastq.gz" -t TTAGGG CCCTAA -o "${SAMPLE}.hi-c_exFun_telomere" -c 20 > "${SAMPLE}.hi-c_exFun_telomere.log" 2>&1

#review manually -> manually remove scaffold 24 and 25 from the assembly
#rename final assembly ${TAPESTRY_DIR}/${SAMPLE}.hi-c.fasta -> copy or move to ${ASSEMBLY_RES_DIR}
#Uncomment to run after review:
##cp "${TAPESTRY_DIR}/${SAMPLE}.hi-c.fasta" "${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta"