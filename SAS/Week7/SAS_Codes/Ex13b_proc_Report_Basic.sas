proc report data=sashelp.cars nowd;
   column make type invoice invper msrp msrpper;
   define make / group;
   define type / group;
   define invper / computed format=percent8.1 'Invoice/Percent';
   define msrpper / computed format=percent8.1 'MSRP/Percent';

   /* Put the total sum of Type within Make into a DATA step variable */
   compute before make;
      invden = invoice.sum;
      msrpden = msrp.sum;
   endcomp;

/* Compute the percents */
   compute invper;
      if invden > 0 then invper = invoice.sum / invden;
   endcomp;
   compute msrpper;
      if msrpden > 0 then msrpper = msrp.sum / msrpden;
   endcomp;

    compute after make;
     type = 'Total';
   endcomp;
<<<<<<< HEAD

  break after make / summarize suppress skip;
 
run;
=======
  break after make / summarize suppress skip;
 run;

>>>>>>> 9c865858976b73b93e561c0281f0f184629a69bd
