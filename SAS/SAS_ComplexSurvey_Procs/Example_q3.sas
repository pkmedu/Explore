DM 'output' clear;
DM 'log' clear;
proc datasets kill nolist nodetails; quit;
*Example_Surveymeans_ODS.sas;
OPTIONS nocenter obs=max ps=58 ls=132 nodate nonumber ;
libname pufmeps  'S:\CFACT\Shared\PUF SAS files\SAS V8' access=readonly;
ods graphics off;
ods trace on /listing;
proc surveymeans data=pufmeps.h181 mean clm q3;
  stratum varstr;
  cluster varpsu;
  weight perwt15f;
  var TOTEXP15 obvexp15;
  domain sex('2')*diabdx('1');
    run;

