
### Comparing SAS, R, and Python Code

#### SAS Code
```
proc print data=sashelp.iris;
run;
proc contents data=sashelp.iris;
run;
```
#### R Code
```
data(iris)
print(iris)
str(iris)
```
#### Python Code
```
import seaborn as sns
iris = sns.load_dataset('iris')
print(iris)
iris.info()
```


