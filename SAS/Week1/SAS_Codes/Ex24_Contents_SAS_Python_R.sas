
options nocenter nodate nonumber;
proc sql;
select memname, nobs format =comma9. ,
  nvar format=comma9.
from dictionary.tables
where libname='SASHELP' and 
   memname like 'IRIS';
quit;
proc contents data=sashelp.iris position; 
ods select variables;
run;

/************************************************************
# R Code
data(iris)
str(iris)
****************************************************************/

/*****************************************************************
# Python Code
import seaborn as sns
import seaborn as sns
iris = sns.load_dataset('iris')
iris.info()
******************************************************************/
