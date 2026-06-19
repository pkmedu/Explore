
options nocenter nodate nonumber;
proc print  data=sashelp.iris (obs=5); 
run;

/************************************************************
# R Code
data(iris)
str(iris, n=5)
****************************************************************/

/*****************************************************************
# Python Code
import seaborn as sns
iris = sns.load_dataset('iris')
iris.head(n=5)
******************************************************************/
