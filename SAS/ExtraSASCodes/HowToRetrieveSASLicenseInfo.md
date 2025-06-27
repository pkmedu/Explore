
* Topic: How to retrieve SAS License Information 
* Acknowledgements: SAS Technical Support
* Use the program at your own risk (no warranties).

```sas
%macro getInfo;
  options nosyntaxcheck ;
  *LIBNAME _ALL_ LIST;
  %put Site Number: &syssite ;
  %put Host OS: &sysscp; %put &sysscpl;
  %put Hostname: &systcpiphostname ;
  %put Process: &sysprocessname ;
  %put SAS Version: &sysvlong ;
  %let sasroot=%sysget(SASROOT) ;
  %put SASROOT: &sasroot ;
  %put USER: &sysuserid ;
  %put Bitness: &SYSADDRBITS ;
  %put Username: %SYSGET(USERNAME) ;
  %put Random: %SYSGET(SAS_NO_RANDOM_ACCESS) ;
  %put This job started on &sysdate at &systime;
%mend ;
%getInfo ;
```

* C:\Program Files\SASHome\SASFoundation\9.4\sasv9.cfg;


proc options option=RLANG;
run;

 
