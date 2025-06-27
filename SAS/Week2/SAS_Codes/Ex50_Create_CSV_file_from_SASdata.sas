
data _NULL_;
 set sashelp.cars;
 file 'c:\data\cars.txt' dlm=',';
 put (_all_) (+0);
 run;

Proc export data=sashelp.cars  outfile="c:\data\cars_x.csv"   
    dbms=CSV  replace ;
run;

proc contents data=sashelp.cars varnum;
ods select position;
run;

proc contents data=sashelp.cars varnum short;
run;
/* Need to be revised */
data cars;
infile 'c:\data\cars.txt' dlm = ',' truncover;
input Make :$13. Model :$40. Type :$8. Origin :$6. DriveTrain :$5.
      MSRP :dollar8. Invoice :dollar8.  EngineSize :8. Cylinders :8. Horsepower :8. MPG_City :8.
      MPG_Highway :8. Weight :8. Wheelbase :8. Length :8.;
run;
