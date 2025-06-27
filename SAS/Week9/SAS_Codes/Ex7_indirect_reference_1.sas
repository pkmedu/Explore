*Ex7_indirect_reference_1.sas;
%macro ref;
Options symbolgen;
%LET disease1=cvd; 
%LET disease2=cancer;
%LET disease3=stroke;
%LET disease4=hbp;
%LET disease5=diabetes;
%LET last_element=5;
  %DO i = 1 %TO &last_element;
     %put  &&disease&i; 
   %END; 
%mend ref;
%ref

*Get dataset names from a particular folder into a macro variable;

libname LIB 'C:\Data';
proc sql noprint;
 select memname into :ds1 -
 from dictionary.tables
 where libname="LIB";
 %let dscount = &sqlobs;
quit; 
%put &=dscount;
%macro ref;
 %DO i = 1 %TO &dscount;
     %put  &&ds&i; 
 %END; 
%mend ref;
%ref




