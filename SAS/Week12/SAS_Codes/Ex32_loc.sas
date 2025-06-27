* Ex32_LOC.sas (Part 1);
proc iml;
 sort Sashelp.demographics out=Sorted_countries 
    by descending pop;
 varnames = {'Name', 'Pop'};
 use Sorted_countries;
 read all var varnames; 
 close sashelp.demographics;
 idx = loc(pop>140000000);

 mean_world_pop1=pop[:];
 mean_world_pop2=mean(pop);
 mean_world_pop3=sum(pop)/nrow(pop);
 Number_of_countries=nrow(name);
 print (name[idx]) 
       (pop[idx])[format=comma15.];
  print  
   Number_of_countries,
   mean_world_pop1 [format=comma15.],
   mean_world_pop2 [format=comma15.],
   mean_world_pop3 [format=comma15.];
 quit;
* Ex32_LOC.sas (Part 2);
proc iml;
 use sashelp.demographics;
 read all var {name pop};
 close sashelp.demographics;
 pop_India_over_china=pop[loc(name='INDIA')]
          /pop[loc(name='CHINA')]-1;
 print pop_India_over_china[format=percent7.2];
 quit;
* Ex32_LOC.sas (Part 3);
 proc iml;
  use sashelp.demographics;
 read all var {pop}  
      into x[rowname=name colname=pop];
 close sashelp.demographics;
 pop_India_over_china=(x['India', 'pop']/x['China', 'pop'])-1;
 print pop_India_over_china[format=percent7.2];
 quit;





 proc sql outobs=8;
select name, pop
 from sashelp.demographics
 order by pop desc;
 quit;



 
