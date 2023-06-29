# _TRate_
The _TRate_ program computes "rate" of each transcript according to given coverage file. Transcripts are coded by coordinates of their exons (bed file for now, gtf/gff in future). Rate is computed as total _mass_ of exons within the transcript divided by total _length_ of exons. _Mass_ is taken as approximation of the area under coverage curve, i.e. sum of areas of coverage rectangles, and length is computed as sum of lengths of bedgraph intervals within exons.

The _TRate_ program takes in two arguments in fixed order.

1. Exons_file - coordinate sorted bed file that provides locations of exons for the corresponding transcript provided in column 4.

Exons_file format example

     C0000570	10420	10640	Transcript1
     C0000570	128078	128167	Transcript2
     C0000570	128290	128405	Transcript2
     C0000571	72845	73133	Transcript3
     C0000571	73211	73274	Transcript3

2. Coverage_file - coordinate sorted file in bedgraph format - it can contain coverage data (usually normalized) from RNAseq study, ChIPseq, ATACseq and so on.

Coverage_file format example

     C0000570	10481	10549	0.310587
     C0000570	10579	10610	0.41057
     C0000570	128288	128293	1.105

## _USAGE_
### Prerequisites (MUST be in your PATH)
	BEDTOOLS
	AWK
    g++
	
### Installation
Download TRate

cd TRate

make		

In file TRate.sh edit path to TRate folder, e.g.

FOLDER_PATH="your/path/TRate"

### Run TRate on test data

     ./TRate.sh ./data/Exons_file.sbed ./data/Coverage_file.bg

Output will be in a file Coverage_file.rate. 

Output format

     Transcript1	0.341895
     Transcript2	1.98961
     Transcript3	-1

Transcript rate = -1 if no coverage data were found for this transcript.
     


 
