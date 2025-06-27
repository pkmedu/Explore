*Ex4_Multilabel_Format.sas (Part 1);
options nodate nonumber;
proc format ;
 value m_agefmt (multilabel notsorted)
              low-34 = '25-34 Years'
              35-44 = '35-44 Years'
			  45-54 = '45-54 Years'
			  55-64 = '55-64 Years'
              low-49= '25-49 Years'
			  50-64 ='50-64 Years';

	    value m_agefmt_x (multilabel)
              low-34 = '25-34 Years'
              35-44 = '35-44 Years'
			  45-54 = '45-54 Years'
			  55-64 = '55-64 Years'
              low-49= '25-49 Years'
			  50-64 ='50-64 Years';

proc tabulate data=sashelp.heart;
  class AgeAtStart/mlf preloadfmt order=data;  
  var AgeAtdeath;
  table AgeAtStart all, 
    n*format=5.0 all*(AgeAtdeath)*mean*format=4.1;
  Format AgeAtStart m_agefmt.;
  title1 'Value m_agefmt (multilabel notsorted)';
  title2 ' Class AgeAtStart/mlf preloadfmt order=data';
run;

*Ex4_Multilabel_Format.sas (Part 2);
proc tabulate data=sashelp.heart;
  class AgeAtStart/mlf;  
  var AgeAtdeath;
  table AgeAtStart all, 
    n*format=5.0 all*(AgeAtdeath)*mean*format=4.1;
  Format AgeAtStart m_agefmt_x.;
  title1 'Value m_agefmt (multilabel)';
  title2 'Class AgeAtStart/mlf';
run;
 
 
