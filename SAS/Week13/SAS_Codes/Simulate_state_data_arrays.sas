*https://sasnrd.com/sas-index-performance-proc-datasets/;
data MyData;
   length ID 8 first_name $20 last_name $20 gender $1 state $20 birth_date 6 children 3;
 
   array first_namesm{20}$20 _temporary_ ("Paul", "Allan", "Bob", "Michael", "Chris", "David", "John", "Jerry", "James", "Robert",
                                       "William", "Richard", "Thomas", "Daniel", "Paul", "George", "Larry", "Eric", "Charles", "Stephen");
   array first_namesf{20}$20 _temporary_ ("Mary", "Linda", "Patricia", "Barbara", "Elizabeth", "Maria", "Susan", "Margaret", "Lisa", "Nancy",
                                       "Karen", "Betty", "Helen", "Sandra", "Sharon", "Laura", "Michelle", "Angela", "Melissa", "Amanda");
   array last_names{20}$20 _temporary_ ("Smith", "Johnson", "Williams", "Jones", "Brown", "Miller", "Wilson", "Moore", "Taylor", "Hall",
                                      "Anderson", "Jackson", "White", "Harris", "Martin", "Thompson", "Robinson", "Lewis", "Walker", "Allen");
   array states{50}$20 _temporary_ ("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", 
                                "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
                                "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", 
                                "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", 
                                "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", 
                                "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming");
 
   call streaminit(123);
 
   do ID=1 to 10e7;
      if rand("Uniform")<0.5 then do;
         gender="M";
         first_name=first_namesm[ceil(rand("Uniform")*20)];
      end;
      else do;
         gender="F";
         first_name=first_namesf[ceil(rand("Uniform")*20)];
      end;
      last_name=last_names[ceil(rand("Uniform")*20)];
      state=states[ceil(rand("Uniform")*50)];
      birth_date=rand("Integer", '01jan1950'd, '01jan1990'd);
      children=rand("Table", 0.1, 0.2, 0.3, 0.2, 0.1, 0.1)-1;
      output; 
   end;
 
   format birth_date date9.;
run;
proc print data=Mydata (obs=100) noobs; run;
proc freq data=Mydata; tables gender; run;

proc sort data=MyData out=de_duplicated noduprecs;
by first_name;
run;
