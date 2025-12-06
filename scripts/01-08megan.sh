#!/bin/bash

#binning_part2
#work in a dedicated directory to avoid overwriting the original .daa file (diamond output)

#Requirements:
#individual in- and output directories
#diamond output file = ${DIAMOND_DIR}/${SAMPLE}.hic.assembly.diamond.daa
#megan-database.db (individual)

#Variables (set these individually)
SAMPLE="Mel1"
DIAMOND_DIR="/path/to/02quality-assessment/01diamond"
MEGAN_DIR="/path/to/02quality-assessment/02megan"
MEGAN_DB="/path/to/databases/megan"

module load megan/6.24.16

cd "${MEGAN_DIR}"

#Copy diamond output to avoid overwriting
cp "${DIAMOND_DIR}/${SAMPLE}.hic.assembly.diamond.daa" "${MEGAN_DIR}/${SAMPLE}.dia_cp.daa"

time daa-meganizer --in "${MEGAN_DIR}/${SAMPLE}.dia_cp.daa" --longReads -mdb "${MEGAN_DB}/megan-database.db" --lcaAlgorithm longReads --lcaCoveragePercent 90 --readAssignmentMode alignedBases --threads 48 -v > "${MEGAN_DIR}/${SAMPLE}.meg.log" 2>&1

#extract reads on "Fungi" node -> save: ${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta
#Output file -> ${MEGAN_DIR}/${SAMPLE}.hi-c_exFungi.fasta
