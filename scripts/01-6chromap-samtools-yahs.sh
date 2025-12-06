#!/bin/bash

#implementing Hi-C data
#do not execute all at once, juicer post step is only for postprocessing after manual review

#Requirements:
#individual in- and output directories
#assembly output file = ${ASSEMBLY_DIR}/${SAMPLE}.flye/assembly.fasta -> copy into CHROMAP_DIR
#Hi-C raw reads -> paired-end fastq files in HIC_RAW_DIR
#juicer_tools_1.22.01.jar -> place in CHROMAP_DIR (individual)
#Juicebox v2.17.00 for visualization (Robinson et al. 2018, https://doi.org/10.1016/j.cels.2018.01.001)

#Variables (set these individually)
SAMPLE="Mel1"
ASSEMBLY_DIR="/path/to/04assembly"						#Directory containing FLYE assembly
HIC_RAW_DIR="/path/to/hic/hi-c_rawdata"					#Directory containing raw Hi-C fastq files
CHROMAP_DIR="/path/to/hic/01chromap-yahs"
ASSEMBLY="${SAMPLE}_assembly.fasta"						#Assembly fasta copied into CHROMAP_DIR -> see below

module load chromap/0.2.6
module load samtools/1.20
module load yahs/1.2.2

cd "${CHROMAP_DIR}"

#Copy assembly to working directory
cp "${ASSEMBLY_DIR}/${SAMPLE}.flye/assembly.fasta" "${CHROMAP_DIR}/${SAMPLE}_assembly.fasta"

#Build chromap index
chromap -i -r "${ASSEMBLY}" -o "${SAMPLE}.index"

#Map
chromap --preset hic -r "${ASSEMBLY}" -x "${SAMPLE}.index" --remove-pcr-duplicates -1 "${HIC_RAW_DIR}/${SAMPLE}_hi-c_1.fq.gz" -2 "${HIC_RAW_DIR}/${SAMPLE}_hi-c_2.fq.gz" --SAM -o "${SAMPLE}_assembly.chromap.sam" -t 24

#Sort
samtools sort -@ 23 -n -T "${SAMPLE}.chromap.tmp" -m2G -O BAM "${SAMPLE}_assembly.chromap.sam" > "${SAMPLE}_assembly.chromap.sort-name.bam"

samtools faidx "${ASSEMBLY}"

#Run yahs
yahs -o "${SAMPLE}_assembly.chromap.yahs" "${ASSEMBLY}" "${SAMPLE}_assembly.chromap.sort-name.bam"

#Juicer PRE
juicer pre -a -o "${SAMPLE}.assembly.chromap.yahs" "${SAMPLE}_assembly.chromap.yahs.bin" "${SAMPLE}_assembly.chromap.yahs_scaffolds_final.agp" "${ASSEMBLY}.fai" > "${SAMPLE}_assembly_juicerPRE.log" 2>&1

#Juicer tools
java -jar -Xmx32G "${CHROMAP_DIR}/juicer_tools_1.22.01.jar" pre "${SAMPLE}.assembly.chromap.yahs.txt" "${SAMPLE}_assembly.chromap.yahs.juicerPRE.hic.part" <(cat "${SAMPLE}_assembly_juicerPRE.log"  | grep PRE_C_SIZE | awk '{print $2" "$3}')
#Rename for simplicity
mv "${SAMPLE}_assembly.chromap.yahs.juicerPRE.hic.part" "${SAMPLE}_assembly.chromap.yahs.hic"

##Visual analysis with: Juicebox v2.17.00 (Robinson et al. 2018, https://doi.org/10.1016/j.cels.2018.01.001)

#Juicer POST (after manually reviewing assembly in Juicebox)
#Uncomment to run after review:
###juicer post -o "${SAMPLE}.assembly.chromap.yahs" "${SAMPLE}.assembly.chromap.yahs.review.assembly" "${SAMPLE}.assembly.chromap.yahs.liftover.agp" "${ASSEMBLY}"
#${SAMPLE}.chromap.yahs.FINAL.fa --> mv ${SAMPLE}.chromap.yahs.FINAL.fa ${SAMPLE}.hic.assembly.fa