*** Ex36_largest.sas (Part 1);
LIBNAME NEW "C:\SASCourse";
OPTIONS NOCENTER NODATE NONUMBER ;
Data WORK.Have (drop= I J);
  call streaminit (123);
  array X[*] TEST1-TEST5 ASSIGNMENT1 ASSIGNMENT2
             MIDTERM FINAL;
	DO I = 1 TO 12;
	  DO  J = 1 TO DIM(X);
        X[J] = RAND("Integer", 40, 100);
	  END;
	OUTPUT;
	END;
RUN;
TITLE1 'Listing HAVE Data Set';
PROC PRINT DATA=HAVE;
run;

*** Ex36_largest.sas (Part 2);
OPTIONS NOCENTER NODATE NONUMBER ;
DATA NEW.HAVE_X (DROP=T1-T4);
 SET WORK.HAVE (rename=(TEST1=T1 TEST2=T2 TEST3=T3 
                   TEST4=T4 TEST5=T5));
array Test[5] Test1 - Test5;
   do J=1 to 5;
   Test(J)=largest(J, of T1-T5);
end;

 ARRAY RAW[8] TEST1-TEST4 ASSIGNMENT1 ASSIGNMENT2
             MIDTERM FINAL;
 ARRAY WEIGHT[8] _TEMPORARY_ (.05, .05, .05, .05,
                               .10, .10, .30, .30);
 ARRAY WP[8] P_TEST1-P_TEST4 P_ASSIGNMENT1 P_ASSIGNMENT2
             P_MIDTERM P_FINAL;
    DO I = 1 TO 8;
	  WP[I] = RAW[I]*WEIGHT[I];
	END;
	WPT = SUM(OF p:);
 DROP I;
 TITLE1 'Listing NEW.HAVE_X Data Set';
 PROC PRINT DATA=NEW.HAVE_X;
  VAR TEST: P_: WPT;
  FORMAT WPT 5.0;
 RUN;
