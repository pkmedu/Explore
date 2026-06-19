
proc sql;
select sex, weight
    from SASHELP.CLASS
	where weight>
	   (select avg(weight)
	    from SASHELP.CLASS)
order by sex;
quit;

