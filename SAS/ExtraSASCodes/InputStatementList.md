[INPUT STATEMENT: LIST  in SAS Documentation](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/lestmtsref/n0lrz3gb7m9e4rn137op544ddg0v.htm)

See the SAS code for the following examples in the above SAS Documentation.

* Example 1: Reading Unaligned Data with Simple List Input
* Example 2: Reading Character Data That Contains Embedded Blanks
* Example 3: Reading Unaligned Data with Informats
* Example 4: Reading Comma-Delimited Data with List Input and an Informat
* Example 5: Reading Delimited Data with Modified List Input

[Tilde Behavaior](https://communities.sas.com/t5/SAS-Programming/Tilde-behavior/td-p/511954)

[novinosrin](https://communities.sas.com/t5/user/viewprofilepage/user-id/138205)

Without the tilde (~) modifier after the variable name in the INPUT statement below:
```sas
Data student;
infile cards dsd dlm=',' ;
Input id team : $25.;
Cards;
1,"Green House,NCSS"
2,"Green House,ABPS"
3,"Green House,JKLM"
;
```
With the tilde (~) modifier after the variable name in the INPUT statement below:
```sas
Data student1;
infile cards dsd  dlm=',';
Input id team ~ :$25.;
Cards;
1,"Green House,NCSS"
2,"Green House,ABPS"
3,"Green House,JKLM"
;
```
##### When Data Contains Quotation Marks (SAS Documentation)

When you use the DSD option in an INFILE statement, which sets the delimiter to a comma, the INPUT statement removes quotation marks before a value is written to a variable. When you also use the tilde (~) modifier in an INPUT statement, the INPUT statement maintains quotation marks as part of the value.
