/* https://blogs.sas.com/content/iml/2019/01/28/simulate-data-regression-categorical-continuous.html */
/* Program based on Simulating Data with SAS, Chapter 11 (Wicklin, 2013, p. 208-209) */
%let N = 10e8;                  /* 1a. number of observations in simulated data */
%let numCont =  8;               /* number of continuous explanatory variables */
%let numClass = 4;               /* number of categorical explanatory variables */
%let numLevels = 3;              /* (optional) number of levels for each categorical variable */
libname new 'C:\SAS_Files';
data new.SimGLM; 
  call streaminit(12345); 
  /* 1b. Use macros to define arrays of variables */
  array x[&numCont]  x1-x&numCont;   /* continuous variables named x1, x2, x3, ... */
  array c[&numClass] c1-c&numClass;  /* CLASS variables named c1, c2, ... */
  /* the following statement initializes an array that contains the number of levels
     for each CLASS variable. You can hard-code different values such as (2, 3, 3, 2, 5) */
  array numLevels[&numClass] _temporary_ (&numClass * &numLevels);  
 
  do k = 1 to &N;                 /* for each observation ... */
    /* 2. Simulate value for each explanatory variable */ 
    do i = 1 to &numCont;         /* simulate independent continuous variables */
       x[i] = round(rand("Normal"), 0.001);
    end; 
    do i = 1 to &numClass;        /* simulate values 1, 2, ..., &numLevels with equal prob */
       c[i] = rand("Integer", numLevels[i]);        /* the "Integer" distribution requires SAS 9.4M5 */
    end; 
 
    /* 3. Simulate response as a function of certain explanatory variables */
    y = 4 - 3*x[1] - 2*x[&numCont] +                /* define coefficients for continuous effects */
       -3*(c[1]=1) - 4*(c[1]=2) + 5*c[&numClass]    /* define coefficients for categorical effects */
        + rand("Normal", 0, 3);                     /* normal error term */
    output;  
  end;  
  drop i k;
run;     
 
proc glm data=new.SimGLM;
   class c1-c&numClass;
   model y = x1-x&numCont c1-c&numClass / SS3 solution;
   ods select ModelANOVA ParameterEstimates;
quit;
