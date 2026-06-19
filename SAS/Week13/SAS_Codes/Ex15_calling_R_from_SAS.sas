/*Calling R Functions from SAS*/
*Ex15_calling_R_from_SAS;
PROC OPTIONS OPTION=RLANG;
RUN;
PROC IML;
SUBMIT / R;
dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54))
head(dfx)
options(digits=2)
aggregate(age ~ sex, data=dfx, FUN=mean)
ENDSUBMIT;
QUIT;

