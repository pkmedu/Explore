DM "Log; clear; output; clear; odsresults; clear";
data fips;
  length fips 8 state_postal_code $2 state_name_territory $20 ;

  do fips=1 to 95;

   /* FIPNAMEL function converts the FIPS code
      to the corresponding state or U.S. territory name in mixed case" */

    state_name_territory = fipnamel(fips);  

    if state_name_territory ne 'Invalid Code' then do;

   /* FIPSTATE converts 2-digit FIPS codes to 2-character state postal codes */
        state_postal_code = fipstate(fips); 
 
    /* STNAMEL function converts a two-character state postal code 
       to the corresponding state name in mixed casease */ 

		if state_postal_code ne '--' then   
        state_name=stnamel(state_postal_code); 
        else state_name = '  ';
     output;
    end;
  end;
run;
proc print data=fips;
run;
