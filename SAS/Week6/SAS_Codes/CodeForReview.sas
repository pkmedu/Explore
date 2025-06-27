
*SAS Note Sample 24590: Convert variable values from character to numeric or from numeric to character;

/**************************************************************************************
*  SAS does not recommend using the same variable name when doing data conversion
* The following code snippet produces error.
* SAS still considers hired as a character variable. 
* It is not correct to assign a SAS date format to a character variable. 
* You will see $DATE in the ERROR message. 
* SAS will try try to associate a correct character format but it cannot find one.
******************************************************************************************/

* Code snippet 1;
 data _null_;
  hired ='27MAR2003'; /*character variable with a value that is a calendar date */
    hired = input(hired, date9.);  /*replace the character date variable as numeric with SAS date value */
    format hired date9.;
 putlog (_ALL_) (=/);
 run;

/**************************************************************************************
*  While SAS does not recommend using the same variable name when doing data conversion,
*  you can use DROP and RENAME statements as follows.
*  You need to use the old variable name with the format in the FORMAT statement. 
*  This is because the RENAME does not happen until the data is written out.
******************************************************************************************/

 * Code snippet 2;
 data _null_;
  Hired ='27MAR2003';  /*character variable with a value that is a calendar date */
  hired_x1 = input(hired, date9.); /* Create a new numeric variable with a SAS date value */
   drop Hired;
   rename hired_x1 = Hired;
   format hired_x1 date9.;
 putlog (_ALL_) (=/);
 run;
/**************************************************************************************
*  While SAS does not recommend using the same variable name when doing data conversion, 
*  you can just create a new variable, based on the original variable, as follows.
***************************************************************************************/
* Code snippet 3;
 data _null_;
  Hired ='27MAR2003';  /*character variable with a value that is a calendar date */
  hired_x1 = input(hired, date9.); /* Create a new numeric variable with a SAS date value */
 format hired_x1 date9.;
 putlog (_ALL_) (=/);
 run;
***************;

* Code snippet 4;

/****************************************************
  How Data Set Options Interact with System Options
 https://www.math.wpi.edu/saspdf/lgref/1129c02.pdf
*****************************************************/

 proc sql;
  select count(*)
   from sashelp.cars varnum;
 quit;

options nocenter obs = 100;
data new_cars;
 set sashelp.cars (obs=5);
run;
proc print data=new_cars;
var  Make  Model Type Origin DriveTrain
     MSRP  Invoice;
run;






