#!/bin/bash

#binning_part1

#Requirements:
#individual in- and output directories
#hi-c assembly = ${ASSEMBLY_HIC}
#diamond database = blast-nr (2023) -> ${DIAMOND_DB}/nr (individual)

#Variables (set these individually)
SAMPLE="Mel1"
CHROMAP_DIR="/path/to/hic/01chromap-yahs"
ASSEMBLY_HIC="${CHROMAP_DIR}/${SAMPLE}.hic.assembly.fa"
DIAMOND_DB="/path/to/db/blast"
DIAMOND_DIR="/path/to/02quality-assessment/01diamond"

module load ncbi-blast/2.13.0
module load diamond/2.0.15

cd "${DIAMOND_DIR}"

time diamond blastx --db "${DIAMOND_DB}/nr" --query "${ASSEMBLY_HIC}" --threads 40 --more-sensitive --frameshift 15 --range-culling --top 10 --outfmt 100 -v --log --out "${DIAMOND_DIR}/${SAMPLE}.hic.assembly.diamond.daa"
