
/* Optional: Turn on useful options */
options nodate nonumber;
libname new 'c:\Data';
/* Step 1: Inspect data structure */
*proc contents data=new.health_sim varnum;
*ods select position;
*run;
ods listing;
/*
proc freq data=new.health_sim ;
tables sex race marital income education smoking alcohol
       obesity diabetes hypertension;
run;
*/
/* Step 2: Run Logistic Regression */
proc logistic data=new.health_sim descending;
    
    /* Specify categorical variables */
    class sex (ref='Male')
	      marital(ref= 'Single')
          race (ref='White')
          education (ref=' Less than HS')
		  income(ref=' <50K')
          smoking (ref='0')
          alcohol (ref='0') 

          obesity(ref=' <50K')
          diabetes (ref='0')
          hypertension (ref='0') 
		  high_chol (ref='0') 

  
  / param=ref;

    /* Model statement */
    model flu = age
                sex
                education
                race
                smoking
                alcohol
                / lackfit clodds=wald;

    /* Optional: Output odds ratios explicitly */
    oddsratio age;
    

    title "Logistic Regression Model for Flu";
run;
