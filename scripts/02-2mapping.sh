#!/bin/bash

#genome mapping using the hic assembly of Melanina gundecimermaniae

#Requirements:
#individual in- and output directories
#Hi-C assembly of Melanina gundecimermaniae = ${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta
#trimmomatic output files in ${TRIM_DIR} -> *_1P.fq.gz, *_2P.fq.gz

#Variables (set these individually)
SAMPLE="Mel1"
HIC_ASSEMBLY="${ASSEMBLY_RES_DIR}/${SAMPLE}.hi-c.fasta"
TRIM_DIR="/path/to/01trimmomatic"
MEM_DIR="/path/to/02bwa_mem"
FLAG_DIR="/path/to/03flagstat"

EU_SAMPLES=(105 106 107 108 109 110 111 11 112 113 114 115 116 12 123 124 125 126 127 128 129 130 131 13 132 134 135 136 137 138 139 140 141 14 142 143 144 145 146 147 148 149 150 151 15 152 153 154 155 156 157 158 159 160 161 16 162 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 3 32 33 34 35 36 37 38 39 40 41 4 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 9 92 93 94 95 96 97 98 99)
EU_ELEV_SAMPLES=(ESi1 ESi2 ESi3 ESii1 ESii2 ESii3 ESii4 ESii5 ESii6 IT1 IT2 IT3 IT4 IT5 IT6)
NA_ELEV_SAMPLES=(Uph16 Uph17 Uph18 Uph19 Uph22 Uph23 Uph24 Uph25 Uph26 Uph27 Uph28)

module load bwa/0.7.17
module load samtools/1.20

###BWA
cd "${MEM_DIR}"

#link hic assembly here
ln -s "${HIC_ASSEMBLY}" "${SAMPLE}.hi-c.fasta"

#create index
bwa index "${SAMPLE}.hi-c.fasta"

#Europe-wide U. pustulata gradient
for i in "${EU_SAMPLES[@]}"
do time bwa mem -t 20 "${SAMPLE}.hi-c.fasta" "${TRIM_DIR}/S${i}_1P.fq.gz" "${TRIM_DIR}/S${i}_2P.fq.gz" | samtools view -S -b - > "${MEM_DIR}/S${i}_${SAMPLE}.hi-c.bam"
done

#Elevation gradient of U. pustulata, Europe (Spain, Italy)
for i in "${EU_ELEV_SAMPLES[@]}"
do time bwa mem -t 20 "${SAMPLE}.hi-c.fasta" "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" | samtools view -S -b - > "${MEM_DIR}/${i}_${SAMPLE}.hi-c.bam"
done

#Elevation gradient of U. phaea, North America (USA)
for i in "${NA_ELEV_SAMPLES[@]}"
do time bwa mem -t 20 "${SAMPLE}.hi-c.fasta" "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" | samtools view -S -b - > "${MEM_DIR}/${i}_${SAMPLE}.hi-c.bam"
done

###FLAGSTAT
cd "${FLAG_DIR}"

#flagstat
#Europe-wide U. pustulata gradient
for i in "${EU_SAMPLES[@]}"
do time samtools flagstat "${MEM_DIR}/S${i}_${SAMPLE}.hi-c.bam" > "${FLAG_DIR}/S${i}_${SAMPLE}.hi-c_flagstat.log"
done

#Elevation gradient of U. pustulata, Europe (Spain, Italy)
for i in "${EU_ELEV_SAMPLES[@]}"
do time samtools flagstat "${MEM_DIR}/${i}_${SAMPLE}.hi-c.bam" > "${FLAG_DIR}/${i}_${SAMPLE}.hi-c_flagstat.log"
done

#Elevation gradient of U. phaea, North America (USA)
for i in "${NA_ELEV_SAMPLES[@]}"
do time samtools flagstat "${MEM_DIR}/${i}_${SAMPLE}.hi-c.bam" > "${FLAG_DIR}/${i}_${SAMPLE}.hi-c_flagstat.log"
done