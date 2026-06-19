
#### SAS Code
```
proc format;  
value gender_fmt 1 = 'Male'                   
                 2 = 'Female';  
data mydata;   	
  gender = 1; output;   	
  gender = 2; output;
run; 

proc print data=mydata; 
run;

proc print data=mydata; 
format gender gender_fmt.;  
run; 
```

#### R Code
```
gender <- c(1,2) 
mydata <- data.frame(gender) print(mydata) 
 
mydata$gender <- factor(mydata$gender, 
                 levels = c(1,2), 
				 labels = c("Male", "Female")) 
print(mydata)
```

#### Python Code
```
import pandas as pd 
df = pd.DataFrame({'gender':[1,2]})
print(df) 
 
dic = {1:'Male', 2:'Female'} 
df['gender'] = df['gender'].map(dic) 
print(df) 

```