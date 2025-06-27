*Ex28_store_matrix.sas;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
%LET Path=C:\SASCourse\Week12;
libname imlin "&Path";
PROC IML;
reset deflib=imlin;
      USE sashelp.class;
      READ all var _num_ INTO class_male_nummat_ext 
	    where(sex="M");
      READ all var {name} INTO rows where(sex="M");
      cols={age, height, weight};
       reset storage=imlin.Mymat;
	   store class_male_nummat_ext;
	  print class_male_nummat_ext[colname=cols rowname=rows];
      CLOSE sashelp.class;
QUIT;

