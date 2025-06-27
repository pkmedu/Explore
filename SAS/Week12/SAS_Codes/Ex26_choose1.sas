*Ex26_Choose1.sas (Part 1);
proc iml;
id = {1,2,3,4,5};
quiz1= {12,18,13,9,7};
makeup={10, 17, 17, 12, 13};
r_quiz1=choose(makeup>quiz1, makeup, quiz1);
print  id quiz1 makeup r_quiz1;
quit;

*Ex26_Choose1.sas (Part 2);
*Acknowledgements: Xia Kesan SAS-L;
proc iml;
 faulty = {15   12   13,    
           16   29   13,
           15   12   13,
           18   58   11 };
 updates = {.   .    .,       
           16   29   .,
            .   .    .,
           18   58   .};
 want=choose(updates^=.,updates,faulty );
 print want;
 quit;
