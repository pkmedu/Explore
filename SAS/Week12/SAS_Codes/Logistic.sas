/*---------------------------------------------*/
/* Logistic Regression: Flu as Outcome         */
/*---------------------------------------------*/
libname new 'C:\Data';
/* Optional: Check variable distributions */
proc freq data=new.health_sim;
    tables flu sex race smoking alcohol / nocum;
run;

/*---------------------------------------------*/
/* Logistic Regression Model                   */
/*---------------------------------------------*/
proc logistic data=new.health_sim descending;

    /* Declare categorical variables */
    class sex (ref="Female")
          race (ref="White")
          smoking (ref="0")
          alcohol (ref="0") / param=ref;

    /* Model statement */
    model flu = age sex race smoking alcohol
          / clodds=wald expb;

    /* Output predicted probabilities */
    output out=new.flu_pred
        p=pred_prob
        lower=lcl
        upper=ucl;

    title "Logistic Regression Model for Flu";
run;
