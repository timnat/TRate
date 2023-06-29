#!/bin/bash


FOLDER_PATH="/home/newnataliya/From_timnatuk/APPS/APPS_NT/TRate"
#Transcript_rate version 1

# Bedtools should be installed in your Path!

#This program takes in two arguments in fixed order: 
#     Exons file - sorted by coordinates bed file with location of exons belonging to the transcript provided in column 4
#format example
# C0000568	109816	110194	AMEX60DDU001000001.1.bed
# C0000570	39532	39624	AMEX60DDU001000002.1.bed
# C0000570	39699	39934	AMEX60DDU001000002.1.bed
#     Coverage file in sorted bedgraph format - it can contain coverage data from RNAseq study, ChIPseq, ATACseq and so on
# format example
#  C0000568	129865	129896	0.073524
#  C0000568	129896	129965	0.036762
#  C0000570	128344	128444	0.036762 
# This program computes outputs "rate" of each transcript in exons file. Rate is computed as total mass of exons within the transcript divided by total length of these exons, mass is taken as approximation of the area under coverage curve, i.e. sum of areas of coverage rectangles.  
 
#$1 EXONS_by_transcripts.sbed
#$2 SRR2885267.sam.bam.norm0.036762.bg.s
Exons_file=$1
Cov_file=$2

if [ ! -s "$Exons_file" ]; then
    echo "Exons file $Exons_file is empty or doesn't exist, exit now"; 
    exit;
fi

if [ ! -s "$Cov_file" ]; then
    echo "Coverage file $Cov_file is empty or doesn't exist, exit now";
    exit;
fi

if [ ! -s "EXONS_by_transcripts.tmp.sbed" ]; then
   cp $Exons_file EXONS_by_transcripts.tmp.sbed;
fi

Name1=$(basename $Cov_file)
#echo "Name1="$Name1

#echo "Cov_file="$Cov_file

bedtools intersect -sorted -wao -a EXONS_by_transcripts.tmp.sbed -b stdin < $Cov_file | awk '{print $4"\t"$8*$9"\t"$9}'  | sort -k1,1 > $Name1".ra"

$FOLDER_PATH/TRate $Name1".ra" > $Name1".rate.log"

echo "File $Cov_file processed, result is in "$Name1".rate"
echo "Removing intermediate files";
rm $Name1".ra"


