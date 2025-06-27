   * Contributed by Mar keintz to SAS-L 9/25/2018;
/* --------------------------------------------------------------------
   This DATA step reads the data values from DATALINES within the SAS
   code. The values within the DATALINES were extracted from the text
   source file by the Import Data wizard.

    Patient Re-admission if within 3 months of the original admission date
   -------------------------------------------------------------------- */

DATA WORK.READMIT;
    LENGTH
        EPISODE_ID       $ 9
        ADMISSION_NUM      8
        ADMISSION_DATE_ID   8
        PAT_UR_NUM         8
        DISCHARGE_DATE_ID   8
        DRG_CODE_VER_042 $ 4 ;
    FORMAT
        EPISODE_ID       $CHAR9.
        ADMISSION_NUM    BEST6.
        ADMISSION_DATE_ID DATE9.
        PAT_UR_NUM       BEST4.
        DISCHARGE_DATE_ID DATE9.
		DRG_CODE_VER_042 $CHAR4. ;
    INFORMAT
        EPISODE_ID       $CHAR9.
        ADMISSION_NUM    BEST6.
        ADMISSION_DATE_ID DATE9.
        PAT_UR_NUM       BEST4.
        DISCHARGE_DATE_ID DATE9.
        DRG_CODE_VER_042 $CHAR4. ;
    INFILE DATALINES4
        DLM=','
        MISSOVER
        DSD ;
    INPUT
        EPISODE_ID       : $CHAR9.
        ADMISSION_NUM    : ?? BEST6.
        ADMISSION_DATE_ID : ?? DATE9.
        PAT_UR_NUM       : ?? BEST4.
        DISCHARGE_DATE_ID : ?? DATE9.
        DRG_CODE_VER_042 : $CHAR4. ;

DATALINES4;
28-60030,60030,15FEB2013,124,08MAR2013,U66Z
28-142929,142929,04JUL2018,1442,20AUG2018,U66Z
28-124021,124021,30JAN2017,5650,16MAR2017,U66Z
28-104840,104840,31AUG2015,5933,25SEP2015,U66Z
28-106124,106124,29SEP2015,5933,22OCT2015,U66Z
28-129352,129352,16JUN2017,6068,21AUG2017,U66Z
28-57751,57751,10JAN2013,6170,31JAN2013,U66Z
28-66130,66130,13JUN2013,6184,28JUN2013,U66Z
28-59972,59972,14FEB2013,6349,18MAR2013,U66Z
28-61234,61234,07MAR2013,6385,20MAR2013,U66Z
28-63178,63178,12APR2013,6427,13APR2013,U66Z
11-488117,488117,11NOV2017,6527,09DEC2017,U66Z
11-515347,515347,29MAY2018,6527,22JUN2018,U66Z
28-68397,68397,05AUG2013,6557,16AUG2013,U66Z
28-110635,110635,22JAN2016,6648,09FEB2016,U66Z
28-79790,79790,03APR2014,6709,04MAY2014,U66Z
28-82421,82421,16MAY2014,6709,17MAY2014,U66Z
28-83433,83433,05JUN2014,6709,13JUN2014,U66Z
28-85484,85484,08JUL2014,6709,20AUG2014,U66Z
28-88149,88149,29AUG2014,6709,12SEP2014,U66Z
28-72646,72646,13NOV2013,6732,22NOV2013,U66Z
28-73012,73012,20NOV2013,6750,19DEC2013,U66Z
28-73191,73191,21NOV2013,6753,25NOV2013,U66Z
;;;;

/* Keep only readmissions less than 90 days after prior discharge 

   Given your data is sorted by admission date within patient id, 
   all you have to do is compare admission date in one observation 
   with discharge date in the prior obs.   And also delete when 
   the current obs are is the start of a new patient.

*/
proc sort data=readmit; 
 by PAT_UR_NUM ADMISSION_DATE_ID ;
run;

data x_readmit;
 set readmit;
  by PAT_UR_NUM ADMISSION_DATE_ID ;
 lag_discharge_date_id = lag(discharge_date_id);
 days=admission_date_id-lag(discharge_date_id);
 format lag_discharge_date_id DATE9.;
run;

proc print data=x_readmit;
var  PAT_UR_NUM 
     ADMISSION_DATE_ID
	 discharge_date_id
	 lag_discharge_date_id
	 days;
run;
data want;
  set readmit;
  by PAT_UR_NUM ADMISSION_DATE_ID ;
  if first.pat_ur_num=0 and days < 90;
run;
proc print data=want;
var  PAT_UR_NUM 
     ADMISSION_DATE_ID
	 discharge_date_id
	 lag_discharge_date_id
	 days;
run;
