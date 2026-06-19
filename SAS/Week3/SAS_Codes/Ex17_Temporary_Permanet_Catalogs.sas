*Ex17_Temporary_Permanent_Catalogs.sas;
options notes source;
PROC FORMAT; 
     value regionfmt
        1='Northeast' 2='Midwest' 
        3='South'  4='West';
run;
LIBNAME library 'C:\SASCourse\Week3';
PROC FORMAT LIBRARY=library; 
     value regionfmt
        1='Northeast' 2='Midwest' 
        3='South'  4='West';
run;
LIBNAME sds 'C:\SASCourse\Week3';
PROC FORMAT LIBRARY=sds; 
     value x_regionfmt
       1='Northeast' 2='Midwest'
       3='South' 4='West';
run;
LIBNAME xsds 'C:\SASCourse\Week3';
PROC FORMAT LIBRARY=xsds.catalogpop; 
     value regionfmt
        1='Northeast' 2='Midwest' 
        3='South'  4='West';
run;




