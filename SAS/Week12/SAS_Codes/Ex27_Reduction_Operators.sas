*Ex27_Reduction_Operators.sas (Part 1);
*Maximum of the column totals;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
max_c_sum= A[+, <>];
print A max_c_sum ;
quit;

*Ex27_Reduction_Operators.sas (Part 2);
*Minimum of the column totals;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
min_c_sum= A[+, ><];
print A min_c_sum ;
quit;
*Ex27_Reduction_Operators.sas (Part 3);
*Index of the column maxima;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
i_col_maxima=A[<:>,];
print A, i_col_maxima ;
quit;
*Ex27_Reduction_Operators.sas (Part 4);
*Index of the column minima;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 4 1, 5 7 2};
i_col_minima=A[>:<,];
print A, i_col_minima ;
quit;
*Ex27_Reduction_Operators.sas (Part 5);
*Sum of the rowwise maximum values;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
sum_max_r=A[,<>] [+, ];
print A ,sum_max_r ;
quit;
*Ex27_Reduction_Operators.sas (Part 6);
*Totals of selected columns;
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
sum_c12 = A[+, 1:2];
print A, sum_c12 ;
quit;
*Ex27_Reduction_Operators.sas (Part 7);
* Maximum value of the row-column dimension specified; 
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
max_row_1_2_col_1_3 = A[1:2, 1:3] [<>];
print A, max_row_1_2_col_1_3 ;
quit;
*Ex27_Reduction_Operators.sas (Part 8);
* Minimum value of the row-column dimension specified; 
ods html;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
min_row_1_2_col_1_3 = A[1:2, 1:3] [><];
print A, min_row_1_2_col_1_3; 
quit;
*Ex27_Reduction_Operators.sas (Part 9);
* Mean of the each of the three columns;
proc iml;
A = {1 2 3, 4 5 6, 9 8 7, 3 2 1, 5 4 2};
mean_1_2_3 = A[:, ] ;
print A, mean_1_2_3;
quit;






