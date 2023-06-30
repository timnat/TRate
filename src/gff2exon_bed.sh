#!/bin/bash

#bedops and gffread must be installed in your PATH

gff_file=$1
Name1=$(basename $gff_file)
mkdir tmp/
if [ ! -s "tmp/gff.tmp.sgff" ]; then
   cp $gff_file tmp/gff.tmp.sgff;
fi

gffread tmp/gff.tmp.sgff -T -o tmp/gtf.tmp.sgtf
gtf2bed < tmp/gtf.tmp.sgtf | grep -wF exon > tmp/tmp1.bed
awk '{print $1, $2, $3, $11}' tmp/tmp1.bed > tmp/tmp2.bed
awk '{gsub(/\"|\;/,"",$4)}1' tmp/tmp2.bed > $Name1"_exon.bed"

echo "File $gtf_file processed, result is in "$Name1"_exon.bed"
echo "Removing intermediate files";
rm -r tmp/
