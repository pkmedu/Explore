*Ex8_tranwrd_translate.sas;
data _NULL_;
  date1='12/31/2010';
  date1_translate = translate(date1, '-', '/');
  txt = 'Data from surveys';
  txt_tranwrd = tranwrd(txt, 'surveys', 'records');
putlog (_ALL_) (= // +2);
run;

