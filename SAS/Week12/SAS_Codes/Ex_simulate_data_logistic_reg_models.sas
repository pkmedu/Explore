/*---------------------------------------------*/
/* Simulate Health Dataset (N = 8000)           */
/*---------------------------------------------*/
options nodate nonumber;
libname new 'C:\Data';
data new.health_sim;
    call streaminit(12345); /* Reproducibility */

    do id = 1 to 8000;

        /*---------------------------*/
        /* Demographics              */
        /*---------------------------*/
        age = rand("integer", 18, 90);

        if rand("uniform") < 0.5 then sex = "Male";
        else sex = "Female";

        /* Race/Ethnicity */
        r = rand("uniform");
        if r < 0.60 then race = "White";
        else if r < 0.75 then race = "Black";
        else if r < 0.85 then race = "Hispanic";
        else if r < 0.95 then race = "Asian";
        else race = "Other";

        /* Education */
        e = rand("uniform");
        if e < 0.25 then education = "Less than HS";
        else if e < 0.50 then education = "High School";
        else if e < 0.75 then education = "Some College";
        else education = "College Grad";

        /* Income */
        i = rand("uniform");
        if i < 0.30 then income = "<50K";
        else if i < 0.70 then income = "50K-100K";
        else income = "100K+";

        /* Marital Status */
        m = rand("uniform");
        if m < 0.50 then marital = "Married";
        else if m < 0.75 then marital = "Single";
        else marital = "Divorced/Widowed";

        /*---------------------------*/
        /* Behavioral Risk Factors   */
        /*---------------------------*/
        smoking = (rand("uniform") < 0.25);   /* 25% smokers */
        alcohol = (rand("uniform") < 0.60);   /* 60% drinkers */
        exercise = (rand("uniform") < 0.55);  /* 55% physically active */

        /*---------------------------*/
        /* Co-morbid Conditions      */
        /*---------------------------*/
        obesity = (rand("uniform") < (0.20 + 0.01*(age-18)/72));
        diabetes = (rand("uniform") < (0.10 + 0.002*age + 0.10*obesity));
        hypertension = (rand("uniform") < (0.15 + 0.003*age + 0.10*obesity));
        high_chol = (rand("uniform") < (0.20 + 0.002*age));

        /*---------------------------*/
        /* Disease Outcomes (Binary) */
        /* Correlated with risks     */
        /*---------------------------*/

        /* Flu (common, weak risk link) */
        flu = (rand("uniform") < 0.15);

        /* COVID (moderate prevalence) */
        covid = (rand("uniform") < (0.10 + 0.05*(age>60)));

        /* Heart Attack */
        heart_attack = (rand("uniform") < 
                        (0.02 + 0.004*age + 0.10*smoking 
                         + 0.10*hypertension + 0.08*high_chol));

        /* Stroke */
        stroke = (rand("uniform") < 
                  (0.015 + 0.003*age + 0.08*hypertension));

        /* Colon Cancer */
        colon_cancer = (rand("uniform") < 
                        (0.01 + 0.0025*age + 0.05*(age>50)));

        /* Blood Cancer */
        blood_cancer = (rand("uniform") < 
                        (0.005 + 0.0015*age));

        /*---------------------------*/
        /* Clean temporary vars      */
        /*---------------------------*/
        drop r e i m;

        output;
    end;
run;

/*---------------------------------------------*/
/* Quick Checks                                */
/*---------------------------------------------*/

/* Structure */
proc contents data=new.health_sim; run;

/* Summary statistics */
proc means data=new.health_sim mean;
    var age smoking alcohol exercise obesity diabetes hypertension;
run;

/* Frequency checks */
proc freq data=new.health_sim;
    tables sex race education income marital
           flu covid heart_attack stroke colon_cancer blood_cancer / nocum;
run;
