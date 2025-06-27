
* Data_step_view_etc.sas;
data class1 class2;
  set sashelp.class;
 run;

 data class3/view=class3;
  set sashelp.class;
 run;
proc contents data=class3; run;
 
 proc datasets lib=work mt=(data view);
 delete class:;
 run;quit;


  data class4/view=class4;
  set sashelp.class;
 run;

 proc datasets lib=work mt=view;
 delete class4;
 run;quit;
