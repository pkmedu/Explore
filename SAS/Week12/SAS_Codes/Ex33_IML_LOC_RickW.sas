*Ex33_IML_LOC_RickW.sas;
*http://blogs.sas.com/content/iml/2015/01/20/elements-satisfy-logical-expression.html;
proc iml;
x = {. -5 2  5,
    -2  . 3  4,
     4  . . -1};
missingLoc = loc(x=.);             /* missing values */
negativeLoc = loc(x^=. & x<0);     /* nonmissing and negative  */
evenLoc = loc(mod(x,2)=0);         /* n is even if (n mod 2)=0 */
print missingLoc, negativeLoc, evenLoc;

