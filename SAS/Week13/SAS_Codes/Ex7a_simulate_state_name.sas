
*https://communities.sas.com/t5/SAS-Programming/Convert-Full-State-Name-to-Abbreviation/td-p/738723;
DM "Log; clear; output; clear; odsresults; clear";
data fips;
  length fips 8 state_postal_code $2 state_name_territory $20 ;
  do fips=1 to 95;
    state_name_territory = fipnamel(fips); /* FIPNAMEL function converts the FIPS code 
	                                          to the corresponding state or U.S. territory name in mixed case" */
    if state_name_territory ne 'Invalid Code' then do;
        state_postal_code = fipstate(fips); /* FIPSTATE converts two-digit FIPS codes to two-character state postal codes */
	    state_name=stnamel(state_postal_code); /* STNAME function converts a two-character state postal code to the 
		                                        corresponding state name in mixed casease */
     output;
    end;
  end;
run;
proc print data=fips;
run;
