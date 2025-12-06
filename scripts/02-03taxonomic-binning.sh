#!/bin/bash

#taxonomic binnin using the hic assembly of Melanina gundecimermaniae and a custom kraken2/bracken database

#Requirements:
#individual in- and output directories
#trimmomatic output files in ${TRIM_DIR} -> *_1P.fq.gz, *_2P.fq.gz
#kraken database (individual)
#check read length and adjust for bracken

#Variables (set these individually)
TRIM_DIR="/path/to/01trimmomatic"
KRAKEN_DB_DIR="/path/to/kraken-db-directory"
KRAKEN_DIR="/path/to/04kraken"
BRACKEN_DIR="/path/to/05bracken"
READ_LENGTH1="150"										#Check read length and adjust
READ_LENGTH2="100"										#Check read length and adjust

EU_SAMPLES=(105 106 107 108 109 110 111 11 112 113 114 115 116 12 123 124 125 126 127 128 129 130 131 13 132 134 135 136 137 138 139 140 141 14 142 143 144 145 146 147 148 149 150 151 15 152 153 154 155 156 157 158 159 160 161 16 162 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 3 32 33 34 35 36 37 38 39 40 41 4 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 9 92 93 94 95 96 97 98 99)
EU_ELEV_SAMPLES=(ESi1 ESi2 ESi3 ESii1 ESii2 ESii3 ESii4 ESii5 ESii6 IT1 IT2 IT3 IT4 IT5 IT6)
EU_ELEV_SAMPLES_1=(ESii1 ESii2 ESii3 ESii4 ESii5 ESii6)
EU_ELEV_SAMPLES_2=(ESi1 ESi2 ESi3 IT1 IT2 IT3 IT4 IT5 IT6)
NA_ELEV_SAMPLES=(Uph16 Uph17 Uph18 Uph19 Uph22 Uph23 Uph24 Uph25 Uph26 Uph27 Uph28)

module load kraken/2.1.3
module load bracken/2.9

###KRAKEN2
cd "${KRAKEN_DIR}"

#Europe-wide U. pustulata gradient
for i in "${EU_SAMPLES[@]}"
do time kraken2 "${TRIM_DIR}/S${i}_1P.fq.gz" "${TRIM_DIR}/S${i}_2P.fq.gz" --threads 20 --db "${KRAKEN_DB_DIR}" --output S${i}fungi_out_hi-c.fa --classified-out S${i}fungi-class_out_hi-c#.fa --unclassified-out S${i}fungi-unclass_out_hi-c#.fa --report report_S${i}_hi-c.log --paired --gzip-compressed --use-names > S${i}_kraken2_hi-c.log 2>&1
done

#Elevation gradient of U. pustulata, Europe (Spain, Italy)
for i in "${EU_ELEV_SAMPLES[@]}"
do time kraken2 "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" --threads 20 --db "${KRAKEN_DB_DIR}" --output ${i}fungi_out_hi-c.fa --classified-out ${i}fungi-class_out_hi-c#.fa --unclassified-out ${i}fungi-unclass_out_hi-c#.fa --report report_${i}_hi-c.log --paired --gzip-compressed --use-names > ${i}_kraken2_hi-c.log 2>&1
done

#Elevation gradient of U. phaea, North America (USA)
for i in "${NA_ELEV_SAMPLES[@]}"
do time kraken2 "${TRIM_DIR}/${i}_1P.fq.gz" "${TRIM_DIR}/${i}_2P.fq.gz" --threads 20 --db "${KRAKEN_DB_DIR}" --output ${i}fungi_out_hi-c.fa --classified-out ${i}fungi-class_out_hi-c#.fa --unclassified-out ${i}fungi-unclass_out_hi-c#.fa --report report_${i}_hi-c.log --paired --gzip-compressed --use-names > ${i}_kraken2_hi-c.log 2>&1
done


###BRACKEN
cd "${BRACKEN_DIR}"

#Europe-wide U. pustulata gradient
for i in "${EU_SAMPLES[@]}"
do time bracken -d "${KRAKEN_DB_DIR}" -i "${KRAKEN_DIR}/report_S${i}_hi-c.log" -o "${BRACKEN_DIR}/out_S${i}.bracken" -w "${BRACKEN_DIR}/bracken-report_S${i}_hi-c.log" -l S -r "${READ_LENGTH1}" -t 10 | tee "${BRACKEN_DIR}/bracken_S${i}.log"
done

#Elevation gradient of U. pustulata, Europe (Spain1)
for i in "${EU_ELEV_SAMPLES_1[@]}"
do time bracken -d "${KRAKEN_DB_DIR}" -i "${KRAKEN_DIR}/report_${i}_hi-c.log" -o "${BRACKEN_DIR}/out_${i}.bracken" -w "${BRACKEN_DIR}/bracken-report_${i}_hi-c.log" -l S -r "${READ_LENGTH1}" -t 10 | tee "${BRACKEN_DIR}/bracken_${i}.log"
done

#Elevation gradient of U. pustulata, Europe (Italy, Spain2)
for i in "${EU_ELEV_SAMPLES_2[@]}"
do time bracken -d "${KRAKEN_DB_DIR}" -i "${KRAKEN_DIR}/report_${i}_hi-c.log" -o "${BRACKEN_DIR}/out_${i}.bracken" -w "${BRACKEN_DIR}/bracken-report_${i}_hi-c.log" -l S -r "${READ_LENGTH2}" -t 10 | tee "${BRACKEN_DIR}/bracken_${i}.log"
done

#Elevation gradient of U. phaea, North America (USA)
for i in "${NA_ELEV_SAMPLES[@]}"
do time bracken -d "${KRAKEN_DB_DIR}" -i "${KRAKEN_DIR}/report_${i}_hi-c.log" -o "${BRACKEN_DIR}/out_${i}.bracken" -w "${BRACKEN_DIR}/bracken-report_${i}_hi-c.log" -l S -r "${READ_LENGTH1}" -t 10 | tee "${BRACKEN_DIR}/bracken_${i}.log"
done

#Sort and analyze output files as desired
