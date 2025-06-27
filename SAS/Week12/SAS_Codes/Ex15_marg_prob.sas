*Ex15_marg_prob.sas;
*Author: Ksharp - 04/08/2018 
  - Comments on Wicklin 's Code;
proc iml;
cName = {"black" "dark" "fair" "medium" "red"};
rName = {"blue" "brown" "green"};
C = { 6 51 69 68 28,
16 94 90 94 47,
0 37 69 55 38};
/* marginal probability of each column */
colMarg = C[+, ]/c[+]; 
/* marginal probability of each row */
rowMarg = C[ ,+]/c[+]; 
expect=(rowMarg*colMarg)#c[+];
print c;
print colMarg;
print rowMarg;
print expect[r=rName c=cName];
quit;
