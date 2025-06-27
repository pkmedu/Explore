
proc format;
value date_grp_fmt
  low-'03jul1989'd          = 'Pre July 4th 1989'
  '04jul1989'd-'31jul1989'd = [mmddyy8.]
  '01aug1989'd-high         = 'Aug 1-Dec 31, 1995';
;
data have;
do i = 1 to 10000;
  birth_date=rand("Integer", '01jan1950'd, '01jan1990'd);
  output;
end;
format birth_date date9.;
run;

  proc freq data=have;
  tables birth_date;
  format birth_date date_grp_fmt.  ;
  run;
