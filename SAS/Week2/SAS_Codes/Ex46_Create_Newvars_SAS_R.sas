*Ex46_Create_Newcars_SAS_R.sas;
data class_in_SAS;
  set sashelp.class;
  bmi = (weight / (height*height) ) * 703;
  run;
proc print data=class_in_SAS; run;

proc iml;
call ExportDataSetToR("work.class_in_SAS", "class_r");
submit / R;
names(class_r) <- tolower(names(class_r))
str(class_r)
setwd("C:/SASCourse/Week3/SAS_Codes")
save(class_r, file = 'class_r.Rdata')
list.files(pattern="Rdata", 
           full.names = TRUE, 
           ignore.case = TRUE)
endsubmit;
quit;

PROC IML;
SUBMIT / R;
library("dplyr")
setwd("C:/SASCourse/Week3/SAS_Codes")
load("class_r.Rdata")
class <- class_r

class$sex <- factor(class$sex, level=c('M', 'F'),
                                 label=c('male', 'female') 
                   )
class %>%
  mutate(
         bmi = (weight / (height*height) ) * 703
        ) 
head(class)
ENDSUBMIT;
QUIT;
