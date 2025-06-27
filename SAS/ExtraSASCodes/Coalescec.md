
```SAS                                                                                              
proc format;                                                                                                                            
  Value agefmt 1 = '<=17 Yrs'                                                                                                            
               2 = '18-64 Yrs'                                                                                                           
               3 = '65+ Yrs'                                                                                                       
               . = ' ';                                                                                                                   
  Value sexfmt 1 = 'Male'                                                                                                                
               2 = 'Female'                                                                                                              
               . = ' ';                                                                                                                   
  Value hstatusfmt 1 = 'Good-Excellent Health'                                                                                                   
                   2 = 'Poor-Fair Health'                                                                                                           
                   . = ' ';                                                                                                                   
  Value cshcnfmt 1 = 'Special HC Needs'                                                                                                       
                 2 = 'No Special HC Needs'                                                                                                      
                 . = ' ';                                                                                                                   
  value adfmt  1 = 'Asians with Diabetes'                                                                                               
               2 = 'Other races w/wo Diabetes'                                                                                                              
               . = ' ';                                                                                                                   
 run;
```
```SAS                                                                                                                                 
data have;                                                                                                                            
   length composite_var $25;                                                                                                 
   input age_grp sex hstatus cshcn                                                                                                   
         asian_with_diab;       
 
  * create character variables that would give formatted values;                                                                        
  c_age_grp = put(age_grp, agefmt.);                                                                                                      
  c_sex = put(sex, sexfmt.);                                                                                                              
  c_hstatus = put(hstatus, hstatusfmt.);                                                                                                 
  c_cshcn = put(cshcn, cshcnfmt.);                                                                                                    
  c_asian_with_diab = put(asian_with_diab, adfmt.);                                                                                       
                                                                                                                                        
  * create a numeric variable with the first nonmissing value ;                                                        
   n_composite_var = (coalesce(age_grp, sex, hstatus,                                                                                      
                  cshcn, asian_with_diab));    
                                                                                       
  * create a character variable with the first nonmissing value;                                               
     composite_var = (coalescec(of c_:));   
                                                                                                                                        
  datalines;                                                                                                                         
  1 .  .  . .                                                                                                                           
  2 .  .  . .                                                                                                                           
  3 .  .  . .                                                                                                                           
  .  1  . . .                                                                                                                           
  .  2  . . .                                                                                                                           
  .  .  1 . .                                                                                                                           
  .  .  2 . .                                                                                                                           
  .  .  . 1 .                                                                                                                           
  .  .  . 2 .                                                                                                                           
  .  .  . . 1                                                                                                                           
  .  .  . . 2                                                                                                                           
  ;                                                                                                                                     
  run;                                                                                                                                  
proc print data =have;                                                                                                                  
var age_grp sex hstatus cshcn asian_with_diab 
    n_composite_var composite_var;                                                                                       
run;
```
```ascii
                                             asian_
                                               with_    n_composite_
 Obs    age_grp    sex    hstatus    cshcn     diab          var        composite_var

   1       1        .        .         .         .            1         <=17 Yrs
   2       2        .        .         .         .            2         18-64 Yrs
   3       3        .        .         .         .            3         65+ Yrs
   4       .        1        .         .         .            1         Male
   5       .        2        .         .         .            2         Female
   6       .        .        1         .         .            1         Good-Excellent Health
   7       .        .        2         .         .            2         Poor-Fair Health
   8       .        .        .         1         .            1         Special HC Needs
   9       .        .        .         2         .            2         No Special HC Needs
  10       .        .        .         .         1            1         Asians with Diabetes
  11       .        .        .         .         2            2         Other races w/wo Diabetes

```
