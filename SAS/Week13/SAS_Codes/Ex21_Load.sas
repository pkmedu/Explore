*Ex21_Load.sas;
/***********************************************************************
This program automates the following:
- unzips a transport file from the MEPS website
- converts the transport file into a SAS data file
PLEASE CHANGE THE USER-SPECIFIED FOLDER NAME IN THE LIBNAME STATEMENT BELOW
(AT THE END OF THIS PROGRAM)
Written by: Pradip Muhuri with SAS(R) Institute's Technical Support 
************************************************************************/

%macro load_MEPS(filename);
	filename inzip1 "C:\SAS_Files\&filename.ssp.zip";
	proc http 
	 url="https://meps.ahrq.gov/data_files/pufs/&filename.ssp.zip"  
	 out=inzip1;
	run;
	filename inzip2 zip "C:\SAS_Files\&filename.ssp.zip" ;
	 
	/* Read the "members" (files) from the ZIP file */
	data contents(keep=memname isFolder);
	 length memname $200 isFolder 8;
	 fid=dopen("inzip2");
	 if fid=0 then
	  stop;
	 memcount=dnum(fid);
	 do i=1 to memcount;
	  memname=dread(fid,i);
	  /* check for trailing / in folder name */
	  isFolder = (first(reverse(trim(memname)))='/');
	  output;
	 end;
	 rc=dclose(fid);
	 /* this could be automated if more than one file is expected in a zip */
	 call symputx('memname',memname);
	run;
	 %PUT &=MEMNAME;
	/* create a report of the ZIP contents */
	title "Files in the ZIP file";
	proc print data=contents noobs N;
	run;

	/* identify a temp folder in the WORK directory */
	filename sit "%sysfunc(getoption(work))/&memname." ;
	 
	/* hat tip: "data _null_" on SAS-L */
	data _null_;
	   /* using member syntax here */
	   infile inzip2(&memname.) 
	       lrecl=256 recfm=F length=length eof=eof unbuf;
	   file sit lrecl=256 recfm=N;
	   input;
	   put _infile_ $varying256. length;
	   return;
	 eof:
	   stop;
	run;
	 libname test xport "%sysfunc(getoption(work))/&memname.";
	 libname myfolder "C:\MEPS";  /* User-specified folder name */

	 /*verify folder names*/
	 %PUT %SYSFUNC(PATHNAME(WORK));
     %PUT %SYSFUNC(PATHNAME(MyFolder)); 
	 proc copy in=test out=Myfolder; run;
%mend;

/* Form the MEPS website, download/unzip the follwong SAS transport files
   and then convert them into SAS data files in a pernament folder:
*/
%load_meps(h12) %load_meps(h20) %load_meps(h28)
%load_meps(h38) %load_meps(h50) %load_meps(h60)
%load_meps(h70) %load_meps(h79) %load_meps(h89)
%load_meps(h97) %load_meps(h105) %load_meps(h113)
%load_meps(h121) %load_meps(h129) %load_meps(h138)
%load_meps(h147) %load_meps(h155) %load_meps(h163) 
%load_meps(h171) %load_meps(h181)
