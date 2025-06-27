proc options ;
run;
proc iml;
run ExportDataSetToR("Sashelp.Class", "cls");
submit / R;
lm.obj <- lm(Weight~ Height, data=cls)
coef <- coef(lm.obj)
print(coef)
endsubmit;
quit;

/*Calling R Functions from SAS*/
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
PROC OPTIONS OPTION=RLANG;
RUN;
PROC IML;
SUBMIT / R;
a <- 2
paste("a:",a)
b <- 3
paste("b:",b)
c <- a * b
paste("c:",c)
ENDSUBMIT;
QUIT;
