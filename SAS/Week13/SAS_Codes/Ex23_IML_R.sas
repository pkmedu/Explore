*Ex23_IML_R.sas;
/*Acknowledgements:
http://cinsug.org/uploads/3/6/2/9/36298586/winand_sas_and_open_source.pdf
*/

proc iml;
/*Read data into SAS/IML vectors*/
use Sashelp.Class;
read all var {Weight Height};
close Sashelp.Class;

/* Read data into SAS/IML vectors
send matrices to R */

call ExportMatrixToR(Weight, "w");
call ExportMatrixToR(Height, "h");

/*Call R functions for data analysis*/
submit / R;
Model <- lm(w ~ h,
na.action="na.exclude") # a
ParamEst <- coef(Model) # b
Pred <- fitted(Model)
Resid <- residuals(Model)
endsubmit;

/*Transfer results into SAS/IML vectors*/
call ImportMatrixFromR(pe,
"ParamEst");
print pe[r={"Intercept" "Height"}];
ht = T( do(55, 70, 5) );
A = j(nrow(ht),1,1) || ht;
pred_wt = A * pe;
print ht pred_wt;
quit;
