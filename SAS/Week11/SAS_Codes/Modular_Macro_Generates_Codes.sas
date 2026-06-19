*Modular_Macro_Generates_Codes.sas;
*Contributed to SAS-L by Ron RJF Fehd  - 8/17/2017 and Adapted here;
options obs=max nodate nonumber nosource symbolgen;
ods listing;
%Let Path = C:\Users\pmuhuri\SASCourse\Week11\SAS_Codes; 
%put &Path;
%put &=Path;

%macro means(data  = sashelp.class
            ,var   = height
            ,where = 1);
proc means data  = &data
          (where =(&where));
           var     &var;
     title "&data &var &where";
run;
%mend means;
filename mprint "&Path\Modular_Macro_Generated_Code.sas";
options mprint mfile;
%means()
%means(where=sex eq 'F')
%means(where=sex eq 'M')

%means(var=weight)
%means(var=weight,where=sex eq 'F')
%means(var=weight,where=sex eq 'M')

%means(data=sashelp.shoes,var=sales)
