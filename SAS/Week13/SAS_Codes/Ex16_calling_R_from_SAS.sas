*Ex16_calling_R_from_SAS.sas;
data have;
input A$ S1 S2 S3 S4;
datalines;
ex1 1 0 0 0
ex2 0 1 0 0
ex3 0 0 1 0
ex4 1 1 0 0
ex5 0 1 0 1
ex6 0 1 0 0
ex7 1 1 1 0
ex8 0 1 1 0
ex9 0 0 1 0
ex10 1 0 0 0
;

proc export data=work.have
  outfile='c:\SASCourse\have.csv'
  DBMS=CSV replace;
run;


PROC IML;
SUBMIT / R;
MyData=read.csv("c:/SASCourse/have.csv")
print(MyData)
subset(cbind(A=MyData[,1],stack(MyData[-1])),values==1,-2)
ENDSUBMIT;
QUIT;


PROC IML;
SUBMIT / R;
library(tidyverse)
MyData=read.csv("c:/SASCourse/have.csv")
MyData%>%  gather(Type,j,-A)%>%  filter(j==1)%>%  select(-j)
ENDSUBMIT;
QUIT;
