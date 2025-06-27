*Ex13_macro.sas;
*Contributed to SAS-L by Ron RJF Fehd  - 8/17/2017;
 
%macro means(data  = sashelp.class
            ,var   = height
            ,where = 1);
proc means data  = &data
          (where =(&where));
           var     &var;
     title "&data &var &where";
run;
%mend means;
%means()
%means(where=sex eq 'F')
%means(where=sex eq 'M')

%means(var=weight)
%means(var=weight,where=sex eq 'F')
%means(var=weight,where=sex eq 'M')

%means(data=sashelp.shoes,var=sales)
