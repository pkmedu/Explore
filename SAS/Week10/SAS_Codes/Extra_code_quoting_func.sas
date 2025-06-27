%let path = c:\Data;
filename source "c:\Data\exchange_rates.html";
proc http 
    url="https://www.x-rates.com/graph/?from=USD%nrstr(&)to=CAD%nrstr(&)amount=1%nrstr(&)year=2016"
    method="GET"
    out=source;
run;
filename source clear;

* Option 1: Read the HTML File Line by Line;

data exchange_rates_raw;
    infile "c:\Data\exchange_rates.html" lrecl=32767 truncover;
    input line $char32767.;
run;
proc print data=exchange_rates_raw;
run;

/* Option 2: Extract Specific Data from HTML Using SCAN() and INDEX();
  If you need to extract exchange rates or other key information, 
  search for specific tags. */

data exchange_rates;
    infile "c:\Data\exchange_rates.html" lrecl=32767 truncover;
    input line $char32767.;
    
    if index(line, "ExchangeRates") > 0 then do;
        rate = scan(line, 3, " "); /* Adjust as needed */
        output;
    end;
run;
proc print data=exchange_rates;
run;


/* Get years from dropdown options list */
options generic;
filename source "c:\Data\exchange_rates.html";
data year_values;
    length year 8;
    infile source dlm='<' expandtabs truncover;
    input @'<option value="'   @'>' year ??;
if not missing (year);
run;

  data want ;
    informat _rate $20.;
    infile source lrecl=32767 delimiter=">" truncover;
    input @'"avgRate">' _rate;
    rate=input(compress(_rate,'.','kd'),8.);
    output;
    stop;
  RUN;
proc print data=want; run;


