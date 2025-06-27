
Source: Online

Create dataset of unique values by sex.

```sas
proc sql;
create table class as
select unique sex, name, count(name) as count
    from sashelp.class
    group by sex
    order by sex, name;
quit;

proc print data=class;
run;
```

Concatenate names and then output the last sex record.

```sas
data nameslst;
   retain nameslst;
   length nameslst $200 count 8.;
   set class; 
   by sex;
   if first.sex then nameslst= "";
   if name > '' then nameslst=catx(', ', strip(nameslst), strip(name));
   if last.sex then do;
  output; 
 end;
 keep sex nameslst count;
run;
 
title 'Codelist by Sex Group';
proc print data=nameslst;
   var sex count nameslst;
run;
```
