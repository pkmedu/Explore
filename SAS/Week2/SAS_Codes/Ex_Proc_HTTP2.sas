%let path = c:\Data;
%put &path;

/* Step 1: Define the URL as a macro variable and protect special characters */
%let url = https://www.x-rates.com/graph/?from=USD%nrstr(&)to=CAD%nrstr(&)amount=1%nrstr(&)year=2016;

/* Step 2: Fetch the web page's contents using PROC HTTP */
filename source "&path.\exchange_rates.html";

proc http 
    url="%superq(url)"
    method="GET"
    out=source;
run;

filename source clear;
