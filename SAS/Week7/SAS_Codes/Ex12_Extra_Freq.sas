
/*https://www.mwsug.org/proceedings/2016/BB/MWSUG-2016-BB23.pdf*/

proc format;
value Black 1="1.Black Mother" 0="0.Non-Black Mother" ;
value Married 1="1.Married" 0="0.Not Married";
value Boy 1="1.Boy" 0="0.Girl";
value MomSmoke 1="1.Smoking Mother" 0="0.Non-smoking Mother";
value Visit 0="0.No Visit" 1="2.Second Trimester" 2="3.Last Trimester"
3="1.First Trimester";
value MomEdLevel 0="0.High School" 1="1.Some College" 2="2.College"
 3="3.Less Than High School";
run;

proc freq data=sashelp.bweight order=formatted;
tables Black Married Boy MomSmoke Visit MomEdLevel;

Format Black Black. 
 Married Married. Boy Boy. MomSmoke MomSmoke. 
 Visit Visit.  MomEdLevel MomEdLevel.;
run;


proc freq data=sashelp.bweight order=freq;
tables Black Married Boy MomSmoke Visit MomEdLevel;

Format Black Black. 
 Married Married. Boy Boy. MomSmoke MomSmoke. 
 Visit Visit.  MomEdLevel MomEdLevel.;
run;

proc freq data=sashelp.bweight order=internal;
tables Black Married Boy MomSmoke Visit MomEdLevel;

Format Black Black. 
 Married Married. Boy Boy. MomSmoke MomSmoke. 
 Visit Visit.  MomEdLevel MomEdLevel.;
run;

