
%macro makefref(fileref,file);
   %if %length(&fileref) gt 8 %then
       %let fileref = %substr(&fileref,1,8);
   filename &fileref "&file";
%mend makefref;
filename mprint "c:\Data\Fileref_Code.sas";
options mprint mfile;
%makefref(humanresource,/dept/humanresource/report96)
