*Ex6_compress_compbl.sas (Part 1);
data work.HAVE;
 input ICD_string $1-5 +1 label $40.;
   x_string=compress(icd_string, '.');
   x_label=compbl(label);
datalines;
S72.0 Fracture of  head and  neck  of   Fumer
 ;
proc print data=work.HAVE noobs; 
run;

*Ex6_compress_compbl.sas (Part 2);
*http://stackoverflow.com/questions/33881011/using-compress-and-put-input-functions-in-sas;
data work.HAVE1; 
input ID $ 11. State $ 2.;
 ncv=COMPRESS(ID, "-");

   * kd means keep-digits;
   ncv_d=COMPRESS(ID," ", "kd"); 
   ncv_n=COMPRESS(ID," ", "kn"); * kn means keep-numbers;

  /* Input Function is used to convert CHAR to NUM and       *
   * the best. format applies the nearest matching format */
   newncv=input(ncv_d,best.); 
   ncv_num=input(ncv, 12.);
datalines;
334-99-5246 TX
480-86-3211 MD
449-55-9407 VA
345-12-1778 GA
907-63-6280 NY
790-09-9813 WY
319-86-1601 FL
;
proc print data=work.Have1; run;

proc contents data=work.Have1 p;
ods select position;
run;

