

%LET RootFolder= C:\Data;
FILENAME MYLOG "&RootFolder\Dopen_Dread_x.sas_log.TXT";
FILENAME MYPRINT "&RootFolder\Dopen_Dread_x.sas_OUTPUT.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

/* The code is obtained from:
	From: https://blogs.sas.com/content/sasdummy/2015/05/11/using-filename-zip-to-unzip-and-read-data-files-in-sas/ 
*/
%let zp = C:\xdata; 
filename inzip zip "&zp.\My_zip_files.zip" debug; 
*filename inzip zip "C:\xdata\My_zip_files.zip" debug; 
	data contents2 (keep=memname isFolder);
	 length memname $200 isFolder 8;
	 fid=dopen("inzip");
	 if fid=0 then
	  stop;
	 memcount=dnum(fid);
	 do i=1 to memcount;
	  memname=dread(fid,i);
	  /* check for trailing / in folder name */
	  isFolder = (first(reverse(trim(memname)))='/');
	  output;
	 enddclose(fid);
	 /* ;
	 rc=this could be automated if more than one file is expected in a zip */
	 call symputx('memname2',memname);
	run;
	 %PUT &=MEMNAME2;
	/* create a report of the ZIP contents */
	title "Files in the ZIP file";
	proc print data=contents2 noobs N;
	run;

	Proc printto;
	run;








