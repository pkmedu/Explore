
### SAS programs typically include one or more of the following:

* DATA Step 

	[Reading raw data into SAS](https://blogs.sas.com/content/sgf/2021/02/18/turning-text-files-into-sas-data-sets-6-common-problems-and-their-solutions/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed:+TheSasTrainingPost+\(The+SAS+Learning+Post+-%3e+SAS+Users\))
	
	[Manipulating data](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/lepg/n0as7mypc9a9pkn1qfj1316b2ics.htm)

* PROC Step 

	[Soring data, formatting data values, and writing reports](https://www.sas.com/content/dam/SAS/support/en/sas-global-forum-proceedings/2019/3068-2019.pdf) 

	[Summarizing data](https://www.sas.com/content/dam/SAS/support/en/sas-global-forum-proceedings/2020/4092-2020.pdf)

	[Routing Log and Output to External Files](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/proc/p1hwvc03z4tqlkn1owzhzo8e7ulu.htm)

* Global Statements 

	[LIBNAME statement](https://documentation.sas.com/?docsetId=lestmtsref&docsetTarget=n1nk65k2vsfmxfn1wu17fntzszbp.htm&docsetVersion=9.4&locale=en)
 
	[OPTIONS statement](https://documentation.sas.com/?docsetId=lesysoptsref&docsetTarget=n0xqwo95drfa24n1hm5nlss33a3s.htm&docsetVersion=9.4&locale=en) 

	[TITLE/FOOTNOTE statement](https://documentation.sas.com/?docsetId=grstatproc&docsetTarget=n1ukd9sqgqiwwhn1mrx4c1rbse1j.htm&docsetVersion=9.4&locale=en)

*  Macro code

	[Macro variables and macros](https://www.sas.com/content/dam/SAS/support/en/sas-global-forum-proceedings/2019/3511-2019.pdf) 

	[Macro Functions](https://blogs.sas.com/content/sgf/2020/04/22/how-to-create-and-use-sas-macro-functions/)

* Output Delivery System (ODS) code 

	[ODS Basics](https://support.sas.com/resources/papers/proceedings/proceedings/sugi29/245-29.pdf)

	[Controlling PROC output](https://sasnrd.com/sas-ods-trace-select-exclude/)

	[Storing any statistic created by PROCs](https://blogs.sas.com/content/iml/2017/01/09/ods-output-any-statistic.html)

### Sample SAS Program
```
		*** Simulate data in a DATA step;
		
		options nocenter ninumber nodate;
		data work.hat;
		  do x =  -5 to 5 by .5;
			do y = -5 to 5 by .5;
			  z = sin(sqrt(y*y + x*x));
			  output;
			end;
		  end;
		run;
		
	   *** Get the metadata;	
	   proc contents data = work.hat varnum;
	      ods select position;
	   run;

		*** Draw a chart in a PROC step;
		proc g3d data = work.hat;
		   plot y*x=z;
		run;
```

### SAS Interface

* [SAS Windowing Environment](https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/lepg/p1g1z9eg910jban14ka4q6piemof.htm)

* [SAS Studio via SAS ODA in the cloud](https://libguides.library.kent.edu/SAS/OnDemand)

* [JupyterLab](https://communities.sas.com/t5/SAS-Communities-Library/Installing-SASPy-Kernel-for-Jupyter-Notebooks-and-Jupyter-Lab/ta-p/464873)

