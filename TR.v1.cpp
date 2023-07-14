
/* Changed command line processing interface compared to v2 */

#include <unistd.h>
#include <stdio.h>

#include <fstream>
#include <string>
#include <string.h>
#include <iostream>
#include <sstream>
#include <stdlib.h>

using namespace std;
 
int main( int argc , char** argv ) {


   char fName[1000]="", fff[1000]="";
  
   //printf ("optind=%d argv[optind]=%s strlen(argv[optind])=%d \n",optind,argv[optind],strlen(argv[optind]));
    if (optind >= argc) {
        fprintf(stderr, "Expected *.area.bed file\n");
        fprintf(stderr, "Usage: *.area.bed\n");
        exit(EXIT_FAILURE);
    }

   //strncat(fname,"",0);
   strncat(fName,argv[optind],strlen(argv[optind]));
   //printf ("fName=%s\n",fName);
  
   
   std::ifstream area_file( fName ) ;
   if (!area_file) {
	fprintf(stderr, "Can't open input file %s\n",fName);	
        exit(EXIT_FAILURE);
    }

   std::string line;
   string trans="", trans_pred="", areas, widths;
   int linecount=0;
   float rate, area, width, area_sum=0, width_sum=0;

   sprintf(fff, "%ste", fName);
   std::ofstream outfile(fff);
   printf("out=%s",fff);

    while ( getline( area_file , line ) ) {
	 //std::cout << linecount << ": " << line << '\n' ;//supposing '\n' to be line end
	 //linecount++ ;
	 stringstream ss(line);
         getline(ss,trans, '\t');
	 //	cout << "Transcript: " << trans << " trans_pred: "<<trans_pred<<endl;
         getline(ss,areas, '\t');
	 area=atof(areas.c_str());
         //       cout << "area: " << area <<endl;
         getline(ss,widths, '\t');
         width=atof(widths.c_str());
         //       cout << "width: " << width <<endl;

        if(trans_pred != trans) 
         { 
          if(width_sum>0)  rate=area_sum/width_sum;
          else rate=0;
              
          if(trans_pred!="") outfile << trans_pred << "\t" << rate << endl;   

           area_sum=area;
           width_sum=width;
	 }
        else
           { area_sum+=area;
             width_sum+=width;
           }

         trans_pred=trans;
        }

   //process last record
    if(width_sum>0)  rate=area_sum/width_sum;
          else rate=0;

          outfile << trans_pred << "\t" << rate << endl;   

   outfile.close();
   area_file.close();
  cout << endl << "END";
}
