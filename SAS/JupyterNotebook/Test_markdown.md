[PUT STATEMENT: LIST in SAS Documentation](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/lestmtsref/p0jcwhe1ofmb49n1xf1q2kc44b0v.htm#n0vulzhql0zmvqn1pwc1fvsxom7f)
```sas
data \_null_;

input salesrep : \$10. tot : comma6. date : date9.;

file log delimiter=" " dsd;

put 'Week of ' date : worddate15.

salesrep : \$12. 'sales were '

tot : dollar9. + (-1) '.';

datalines;

Wong 15,300 12OCT2004

Hoffman 9,600 12OCT2004
```sas
;
