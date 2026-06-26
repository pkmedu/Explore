/*-----------------------------------------------------------
  Main Report
-----------------------------------------------------------*/
proc report data=emb_2025_s nowd split='|';

   columns district
           i_sn
           i_loc
           i_date
           i_description
           i_info_s;

   define district / order "District";
   define i_sn / display "Serial No.";
   define i_loc / display "Location";
   define i_date / display "Date";
   define i_description / display flow "Incident Description";
   define i_info_s / display flow "Source";

   break after district / skip;

run;


/*-----------------------------------------------------------
  Summary Statistics (After Table)
-----------------------------------------------------------*/
proc odstext;
p "
<br>

<table style='width:50%;
              margin-left:auto;
              margin-right:auto;
              border-collapse:collapse;
              font-size:14px;'>

<tr>
<th style='padding:8px;border:1px solid #cccccc;background:#EAF2F8;'>
Total Incidents
</th>

<th style='padding:8px;border:1px solid #cccccc;background:#EAF2F8;'>
Districts Affected
</th>
</tr>

<tr>
<td style='text-align:center;border:1px solid #cccccc;font-weight:bold;'>
&n_cases
</td>

<td style='text-align:center;border:1px solid #cccccc;font-weight:bold;'>
&n_districts
</td>
</tr>

</table>

<br>
";
run;


/*-----------------------------------------------------------
  Footer
-----------------------------------------------------------*/
proc odstext;
p "
<hr>

<p style='font-size:10pt;'>

Data Source:
<a href='https://www.bhbcuc.org' target='_blank'>
Bangladesh Hindu Buddhist Christian Unity Council
</a>

<br>

Generated:
%sysfunc(datetime(),datetime20.)

</p>
";
run;
