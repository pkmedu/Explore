options nocenter ps=58 ls=92 obs=max nodate nofmterr mprint symbolgen merror mlogic;
libname library "U:\A_Datarequest";
%macro tablerun;
%DO yy = 08 %to 13;
proc DESCRIPT  data=library.fyc%sysfunc(putn(&yy, z2.)) FILETYPE=SAS DESIGN=WR;
		nest varstr varpsu /missunit;
		weight  perwt%sysfunc(putn(&yy, z2.))f;
		var TOTEXP%sysfunc(putn(&yy, z2.))
		    r_totprv%sysfunc(putn(&yy, z2.))
            TOTMCR%sysfunc(putn(&yy, z2.)) 
            TOTMCD%sysfunc(putn(&yy, z2.));
        setenv colwidth=12 decwidth=3;
		print nsum total setotal /style=nchs
   		   nsumfmt=F10.0  totalfmt=F16.1 setotalfmt=F16.2;
           OUTPUT nsum total setotal / filename =work.table_%sysfunc(putn(&yy, z2.)) filetype=SAS  replace;       
    run;
%end;
%mend tablerun;
%tablerun

%let keepvar = nsum total setotal _C1;
data library.comb (drop=_C1);
  set work.table_08 (keep=&keepvar)
       work.table_09 (keep=&keepvar)
	    work.table_10 (keep=&keepvar)
	     work.table_11 (keep=&keepvar)
	      work.table_12 (keep=&keepvar)
		   work.table_13 (keep=&keepvar)
		    INDSNAME=yr;
	 year = 20||substr(yr,12,2);
     total=total/1000000000;
     setotal=setotal/1000000000;
  where _C1 = 1;
run;
proc print data = work.comb noobs; var year nsum total setotal;  run;

%macro create_csv(data_points=, type=);
%let tot_points = %STR(1,5,9,13,17,21);
%let prv_points = %STR(2,6,10,14,18,22);
%let mcare_points = %STR(3,7,11,15,19,23);
%let mcaid_points = %STR(4,8,12,16,20,24);
   data &type;
    do slice = %unquote(&data_points);
        set work.comb point=slice;
		output;
	end;
	stop;
   run;

ods excel file="U:\A_DataRequest\&type..xlsx";
proc print data=&type noobs;
var year nsum total setotal;
run;
ods excel close;
%mend create_csv;
%create_csv (data_points= %nrstr(&tot_points), type=total)
%create_csv (data_points= %nrstr(&prv_points), type=private)
%create_csv (data_points= %nrstr(&mcare_points), type=medicare)
%create_csv (data_points= %nrstr(&mcaid_points), type=medicaid)


