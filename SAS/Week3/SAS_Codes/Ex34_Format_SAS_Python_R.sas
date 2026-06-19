options nocenter nodate nonumber;
options nocenter nodate nonumber;
proc format;
value gender_fmt 1 = 'Male'
                 2 = 'Female';
data mydata;
	gender = 1; output;
	gender = 2; output;
proc print data=mydata;
proc print data=mydata;
format gender gender_fmt.;
run;


/*******************************************************
#Python Code
import pandas as pd
# Create a data frame
df = pd.DataFrame({'gender':[1,2]})
# Print the DataFrame
print(df)

# Create dictionary
dic = {1:'Male', 2:'Female'}
# Use the .map() method to transform the original data values
df['gender'] = df['gender'].map(dic)
# Print matching values
print(df)
********************************************************/


/************************************************************
# R code
name   <- c('Dexiu', 'Doug', 'Fred', 'Yichi')
level  <- c('Graduate', 'Graduate', 'Undergraduate', 'Undergraduate')
sas    <-  c('yes', 'no', 'no', 'no')
r      <- c('yes', 'yes', 'no', 'yes')
python  <- c('yes', 'no', 'no', 'yes')

data <- data.frame(name, level, sas, r, python)
print(data)
**************************************************************/
