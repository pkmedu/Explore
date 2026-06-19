options notes source;

%let path = %nrstr(C:\Data\Research&Development\Report(100%).txt);
%put &=path;

filename myfile "%unquote(&path)";
%put FILEREF RC = &sysfilrc;

data _null_;
    file myfile;
    putlog ">>> Attempting to write...";
    put "File written successfully";
run;
