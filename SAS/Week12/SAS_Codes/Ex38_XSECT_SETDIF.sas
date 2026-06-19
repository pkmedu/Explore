*Ex38_XSECT_SETDIF.sas (Part 1);
* Contributed by Rick Wicklin to SAS-L - 12/28/2016;
proc iml;
candidates = {Name, Sex, Income};
varNames = contents("sashelp","class");
In = xsect(upcase(candidates), upcase(varNames));
Out = setdif(upcase(candidates), upcase(varNames));
print In[label="Vars In Data"], Out[label="Vars Not In Data"];
quit;
*Ex38_XSECT_SETDIF.sas (Part 2);
proc iml;
varNames_d1 = contents("sashelp","class");;
varNames_d2 = contents("sashelp","classfit");
In = xsect(upcase(varNames_d1), upcase(varNames_d2));
Out = setdif(upcase(varNames_d1), upcase(varNames_d2));
*print In[label="Vars In Data"], Out[label="Vars Not In Data"];
nrow_d1=nrow(varNames_d1);
nrow_d2=nrow(varNames_d2);
print varNames_d1 varNames_d2, nrow_d1 nrow_d2;
quit;
/*
The XSECT function returns as a row vector the sorted set
(without duplicates) of the element values that are present 
in all of its arguments. This set is the intersection of the
sets of values in its argument matrices. 
When the intersection is empty, the XSECT function returns
an empty matrix with zero rows and zero columns.
There can be up to 15 arguments, which must all be either 
character or numeric.”  SAS® Documentation.
The SETDIF function returns as a row vector the sorted set 
(without duplicates) of all element values present in A but 
not in B. If the resulting set is empty, the SETDIF function
returns an empty matrix with zero rows and zero columns.
SAS® Documentation.

*/
