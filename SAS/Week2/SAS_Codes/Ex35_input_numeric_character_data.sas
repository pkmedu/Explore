*Adapted from SAS Documentation ;
*Exa35_input_numeric_character_data.sas (Part 1);
options nocenter nodate nonumber nosource;
data Have1;
 input some_numbers 1-6;
 datalines;
   23    /*input right aligned*/
 23      /*input not aligned */
23       /*input left aligned*/
00023    /*input with leading zeros*/
23.0     /*input with decimal point*/
2.3E1    /*in E notation, 2.30*/
230E-1   /*in E notation, 230x10*/ 
-23
;
title 'Have1 Data Set';
proc print data=Have1 noobs; run;
/*
The BZw.d informat reads numeric values, converts 
    any trailing or embedded blanks to 0s, and ignores leading blanks.
 The BZw.d informat ignores blanks between a minus sign and 
  a numeric value in an input field.
*/
*Exa35_input_numeric_character_data.sas (Part 2);
options nocenter nodate nonumber nosource;
data Have2;
 input @1 some_numbers bz4.;
 datalines;
2 3      /*embedded blank in the data - COMMA. or BZ. informat*/
- 23     /*embedded blank in the data - COMMA. or BZ. informat*/
;
title 'Have2 Data Set';
proc print data=Have2 noobs; run;

*Exa35_input_numeric_character_data.sas (Part 3);
options nocenter nodate nonumber nosource;
data Have3;
 input @1 some_numbers comma6.;
 /*comma in the data - COMMA. informat*/
 /*parentheses in the data - COMMA. informat*/
 datalines;
2,341
(23)  
;
title 'Have3 Data Set';
proc print data=Have3 noobs; 
run;


