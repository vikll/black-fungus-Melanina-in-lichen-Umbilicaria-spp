#!/bin/bash

#preparation of raw metagenomes; trim adapters, filter -> trimmomatic

#Requirements:
#individual in- and output directories
#raw data for Europe-wide U. pustulata gradient = ${RAW_EU_DIR}
#raw data for elevation gradient of U. pustulata, Europe (Spain, Italy) = ${RAW_ELEVEU_DIR}
#raw data for elevation gradient of U. phaea, North America (USA) = ${RAW_ELEVUS_DIR}
#adapters.fasta with adapter sequences (individual)
#make sure that rawdata filenames match with the script, otherwise adjust

#Variables (set these individually)
SAMPLE="Mel1"
RAW_EU_DIR="/path/to/00rawdata/01rawdata-Europe-range"
RAW_ELEVEU_DIR="/path/to/00rawdata/02rawdata-Europe-elevation"
RAW_ELEVUS_DIR="/path/to/00rawdata/03rawdata-NorthAmerica-elevation"
TRIM_DIR="/path/to/01trimmomatic"
ADAPTERS="/path/to/adapters.fasta"

EU_SAMPLES=(105 106 107 108 109 110 111 11 112 113 114 115 116 12 123 124 125 126 127 128 129 130 131 13 132 134 135 136 137 138 139 140 141 14 142 143 144 145 146 147 148 149 150 151 15 152 153 154 155 156 157 158 159 160 161 16 162 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 3 32 33 34 35 36 37 38 39 40 41 4 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 9 92 93 94 95 96 97 98 99)
EU_ELEV_SAMPLES=(ESi1 ESi2 ESi3 ESii1 ESii2 ESii3 ESii4 ESii5 ESii6 IT1 IT2 IT3 IT4 IT5 IT6)
NA_ELEV_SAMPLES=(Uph16 Uph17 Uph18 Uph19 Uph22 Uph23 Uph24 Uph25 Uph26 Uph27 Uph28)

module load trimmomatic/0.39

cd "${TRIM_DIR}"

#Europe-wide U. pustulata gradient
for i in "${EU_SAMPLES[@]}"
do time trimmomatic PE -threads 20 -phred33 "${RAW_EU_DIR}/S${i}_1.fq.gz" "${RAW_EU_DIR}/S${i}_2.fq.gz" "${TRIM_DIR}/S${i}_1P.fq.gz" "${TRIM_DIR}/S${i}_1U.fq.gz" "${TRIM_DIR}/S${i}_2P.fq.gz" "${TRIM_DIR}/S${i}_2U.fq.gz" ILLUMINACLIP:"${ADAPTERS}":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 > "${TRIM_DIR}/S${i}_trimmomatic.log" 2>&1
done  

#Elevation gradient of U. pustulata, Europe (Spain, Italy)
for i in "${EU_ELEV_SAMPLES[@]}"
do time trimmomatic PE -threads 20 -phred33 "${RAW_ELEVEU_DIR}/${i}_1.fq.gz" "${RAW_ELEVEU_DIR}/${i}_2.fq.gz" "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_1U.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" "${TRIM_DIR}/${i}_2U.fq.gz" ILLUMINACLIP:"${ADAPTERS}":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 > "${TRIM_DIR}/${i}_trimmomatic.log" 2>&1
done  

#Elevation gradient of U. phaea, North America (USA)
for i in "${NA_ELEV_SAMPLES[@]}"
do time trimmomatic PE -threads 20 -phred33 "${RAW_ELEVUS_DIR}/${i}_1.fq.gz" "${RAW_ELEVUS_DIR}/${i}_2.fq.gz" "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_1U.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" "${TRIM_DIR}/${i}_2U.fq.gz" ILLUMINACLIP:"${ADAPTERS}":2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 > "${TRIM_DIR}/${i}_trimmomatic.log" 2>&1
done  