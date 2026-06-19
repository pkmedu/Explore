*Ex21_Access_Macro.sas;
libname Mylib 'C:\SASCourse\Compiled_Macros';
options mstored sasmstore=Mylib;
ods Excel file="C:\SASCourse\Week10\List_SAS_Files_x.xlsx"; 
%macro mexcel (start, stop); 
%DO num = &START %TO &STOP;
        ods excel options(sheet_name="Week&num");
		data _null_;                                                                                                                            
 		  file print;                                                                                                                 
         %drive(C:\SASCourse\Week&num,sas)                                                                                                                   
         run;  
%end;   
ods Excel close; 
%mend mexcel;
/* Create an Excel Workbook with two sheets, listing 
  .SAS files from Week7 and Week8 folders, respectively*/
%mexcel (6,7)
