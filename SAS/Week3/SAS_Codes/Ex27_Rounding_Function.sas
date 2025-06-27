*Ex27_Rounding_Function.sas;
Data Have;
value=525.686;
nearest_integer=round(value);   /*rounds to the nearest integer   */
nearest_100=round(value,100);   /*rounds to the nearest hundred   */
nearest_ten=round(value,10);    /*rounds to the nearest ten       */
nearest_10th=round(value,.1);   /*rounds to the nearest tenth     */
nearest_100th=round(value,.01); /*rounds to the nearest hundredth */

run;
proc print data=Have;
run;
/*
 https://blogs.sas.com/content/iml/2011/10/03/rounding-up-rounding-down.html
  - Rick Wicklin
*/
