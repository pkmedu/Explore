#### 1. Run the SAS program below that will create a SAS data set, **work.Sample**.
```
dm "log; clear; output; clear; odsresults; clear;";
%let NSim = 28000;  /** sample this many times **/
data work.Sample (drop=i); 
    call streaminit(54321); 
	num_id = _N_;
    do i = 1 to &NSim;
        race = rand("Table", 0.188, 0.124, 0.060,.628);
        sex = rand("Table", 0.510, 0.499);
        region = rand("Table", 0.167, 0.256, 0.382, 0.245);
        metro_status = rand("Table", 0.862, 0.132);        
    output; 
    end; 
run;
```
#### 2. Read **work.Sample** as an input SAS data set and create a new SAS data set, **mylib.sample** using a DATA step. In the step, do the following:
* Create the following character variables:

    * **char_id** - a 5-byte character id by padding it with leading zeros, if any of the the original variable's (**num_id**) data values,  is less than 5 bytes.

    * **char_race** - a character variable whose values are to be translated from 
    1 to 'Hispanic',  2 to 'Non-Hispanic Black', 3 to 'Asian', and 4 to 'Other'.
    
