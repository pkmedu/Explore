*Ex19_Compiled_Macro.sas;
*** This is a revised version of the macro obtained from 
    http://support.sas.com/kb/45/805.html
    [Sample 45805: List all files within a directory including 
     sub-directories]
    Revisions: Macro calls are wrapped in data steps; 

/* The following two lines and the options to the macro
   are added by Pradip Muhuri 
 */
Libname MyLib 'C:\SASCourse\Compiled_Macros';
options mstored sasmstore=MyLib;
%macro drive(dir,ext) /store source
        des='Listing SAS Files';  
  /* Defime macro variables */ 
  %local filrf rc did memcnt name i;                                                                                                    
                                                                                                                                        
  /* Assigns a fileref to the directory and opens the directory */                                                                      
  %let rc=%sysfunc(filename(filrf,&dir));                                                                                               
  %let did=%sysfunc(dopen(&filrf));                                                                                                     
                                                                                                                                        
  /* Make sure directory can be open */                                                                                                 
  %if &did eq 0 %then %do;                                                                                                              
   %put Directory &dir cannot be open or does not exist;                                                                                
   %return;                                                                                                                             
  %end;                                                                                                                                 
   /* Loops through entire directory */                                                                                                 
   %do i = 1 %to %sysfunc(dnum(&did));                                                                                                  
                                                                                                                                        
     /* Retrieve name of each file */                                                                                                   
     %let name=%qsysfunc(dread(&did,&i));                                                                                               
                                                                                                                                        
     /* Checks to see if the extension matches the parameter value */                                                                   
     /* If condition is true print the full name to the log        */                                                                   
      %if %qupcase(%qscan(&name,-1,.)) = %upcase(&ext) %then %do;                                                                       
        put "&dir\&name";                                                                                                               
      %end;                                                                                                                             
     /* If directory name call macro again */                                                                                           
      %else %if %qscan(&name,2,.) = %then %do;                                                                                          
        %drive(&dir\%unquote(&name),&ext)                                                                                               
      %end;                                                                                                          
   %end;                                                                                                                                
  /* Closes the directory and clear the fileref */                                                                                      
  %let rc=%sysfunc(dclose(&did));                                                                                                       
  %let rc=%sysfunc(filename(filrf));                                                                                                    
%mend drive; 
%sysmstoreclear;   /* Added by Pradip Muhuri*/
