data work.age (keep= name age) work.weight (keep= name weight) work.height (keep= name height) work.sex (keep= name sex) ;
set sashelp.class;
run;
data work.age (keep= name age weight height sex) ;
set sashelp.class;
run;
data work.age (keep= name age) work.weight (keep= name weight) work.height (keep= name height) work.sex (keep= name sex) ;
set sashelp.class;
run;
