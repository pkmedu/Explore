*Ex30_regex.sas;
/*  Code written by Ksharp 
https://communities.sas.com/t5/New-SAS-User/remove-whitespace/m-p/511921#M2277
*/
data _null_;
x='Coming /  not coming  ';
y=prxchange('s/\s+(?=\/)|(?<=\/)\s+//',-1,x);
put x= / y=;
run;



