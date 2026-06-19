*Ex5_Some_Macro_Functions.sas;
*** %SUBSTR Function;
%put &=sysdate9.;
%put Year=%SUBSTR(&sysdate9,6);

*** %LENGTH Function;
%put &sysvlong4;
%put Length_sysvlong4 = %length(&sysvlong4);

*** %SCAN function;
%put &sysuserid;
%put ID_Last_Name=%SCAN(&sysuserid, 2);
%put &SYSTCPIPHOSTNAME;
%put %SCAN(&SYSTCPIPHOSTNAME, 1, '-');

**** %UPCASE Function;
%put ID_UpperCase=%UPCASE(&sysuserid);
