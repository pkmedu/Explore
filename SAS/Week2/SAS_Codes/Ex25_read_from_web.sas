*Ex25_read_from_web.sas;
filename source "c:\Data\world_temperature.csv";
proc http
    url = 'http://ourworldindata.org/grapher/average-monthly-surface-temperature.csv'
     out=source
	 method=get;
run;

data world_temperature;
     infile source dlm=',' truncover firstobs=2 obs=10;
     input 
	       Entity :$20.
           Code :$5.
           year :8.
           x_date ?? :yymmdd10. 
           Average_surface: best32.
           Average_surface_temp :best32.;

	 format x_date mmddyy10.;
	;
run;
proc print data=world_temperature(obs=5); 
run;
