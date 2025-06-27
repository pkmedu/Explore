
proc sql;
    select make, count(make) as count
    from sashelp.cars
    group by make
    order by make
	UNION
    select 'Total' as make, 
           count(*) as count format=comma14.
    from sashelp.cars ;*/
quit;

	proc sql;
    select make, count(make) as count
    from sashelp.cars
    group by make
    UNION
    select 'Total' as make, 
           count(*) as count format=comma14.
    from sashelp.cars
    order by case when make = 'Total' then 1 else 0 end,
             make;
quit;

proc sql;
    select make, 
           count(make) as count,
           (count(make) / (select count(*) 
            from sashelp.cars)) * 100 as percentage format=5.2
    from sashelp.cars
    group by make
    
    UNION
    
    select 'Total' as make, 
           count(*) as count,
           100.00 as percentage format=5.2
    from sashelp.cars
    
    order by case when make = 'Total' then 1 else 0 end,
             make;
quit;


****;
proc report data=sashelp.cars nowd;
    columns make n percentage;

    define make / group 'Make';
    define n / 'Count' format=comma8.;
    define percentage / computed 'Percentage' format=5.2;

    compute before _page_ / style=[just=left];
        line 'Car Makes Summary';
    endcomp;

    compute percentage;
        percentage = (_c2_ / sum(_c2_)) * 100;
    endcomp;

    compute after / style=[just=right];
        make = 'Total';
        n = sum(n);
        percentage = 100.00;
    endcomp;

    rbreak after / summarize;
run;
