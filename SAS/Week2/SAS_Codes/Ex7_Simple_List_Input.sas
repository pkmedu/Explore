*Ex7_Simple_List_Input.sas;

OPTIONS nodate nonumber ps=58 ls=98;
DATA Work.Have1;
    INPUT  st_name $ pop percent_pop18p ;
	DATALINES;
    Alabama 4833722          77
    ;
  PROC PRINT data=work.Have1 noobs; run;
  
  * Use the $ option to read in character data
    and the LENGTH statement to avoid unwanted
    truncation of the values of character variables 
    that are more than  8 chracters long;

  DATA Work.Have2;   
   LENGTH st_name $ 10;                        
    INPUT st_name $ pop percent_pop18p ;
    DATALINES;								
    Alabama            4833722  77
    California 38332521             76.1
  ;
 PROC PRINT data=work.Have2 noobs; run;
  proc contents data=Have2 varnum;
 ods select position;
 run;

 * The INFORMAT statement has the same impact of 
  the LENGTH statement for character variables;

 DATA Work.Have3;   
   INFORMAT st_name $ 10.;                        
    INPUT st_name $ pop percent_pop18p ;
    DATALINES;								
    Alabama 4833722  77
    California 38332521 76.1
  ;
 PROC PRINT data=work.Have3 noobs; run;
 proc contents data=Have3 varnum;
 ods select position;
 run;

 * Use the DLM= option to read in comma delimited data;
 DATA Work.Have4;   
   LENGTH  st_name $ 10; 
    infile datalines DLM=','; 
    INPUT st_name $ pop percent_pop18p ;
    DATALINES;								
    Alabama, 4833722,  77
    California, 38332521, 76.1
  ;
  PROC PRINT data=work.Have4 noobs; run;


 
 /* Use a placeholder for the missing value for
    fields in the middle of the record of the space-delimited file,
    as shown below.
 */

 DATA Work.Have5;   
   LENGTH st_name $ 10;                        
    INPUT st_name $ pop percent_pop18p ;
    DATALINES;								
    Alabama .    77
    California 38332521 76.1
  ;
 PROC PRINT data=work.Have5 noobs; run;

 * Use the @@ option to read in more than one 
 record per line;

  DATA Work.Have6;   
   LENGTH  st_name $ 10;                        
    INPUT st_name $ pop percent_pop18p  @@;
    DATALINES;								
    Alabama 4833722  77   California 38332521 76.1
  ;
  PROC PRINT data =work.Have6 noobs; run;


 /* Use the LABEL and FORMAT statements
 in a DATA step to apply the labels and formats
 to the data table. */

DATA Work.Have7;   
    LENGTH  st_name $ 10;                        
    INPUT st_name $ pop percent_pop18p ;
	FORMAT pop comma10. percent_pop18p 5.1;
	LABEL st_name='State Name'
          pop='Population Size'
	      percent_pop18p='Percentage of Population Aged 18 Years and Older';
    DATALINES;								
    Alabama 4833722  77
    California 38332521 76.1
  ;
  proc print data=work.Have7 noobs label; run;
  proc contents data=work.Have7 varnum;
  ods select position;
  run;

  /* Use a LABEL option (required) with PROC PRINT to display
    descriptive column heading */

  PROC PRINT data=work.Have7 noobs label; 
  run;

  DATA Work.Have8;   
    LENGTH  st_name $ 10;                        
    INPUT st_name $ pop percent_pop18p ;
	DATALINES;								
    Alabama 4833722  77
    California 38332521 76.1
  ;
  /* 
  1) Use the LABEL and FORMAT statement 
  in the PROC step to apply the labels and formats
  to the data table

   2) You must use a SPLIT= option with PROC PRINT 
    to display descriptive column headings with split text.
  */
  PROC PRINT data=work.Have8 noobs split='*';
    FORMAT pop comma10. percent_pop18p 5.1;
	LABEL st_name='State Name'
          pop='Population Size'
	      percent_pop18p='Percentage*of Population* Aged 18 Years* and Older';
     
  run;

  
  
 
