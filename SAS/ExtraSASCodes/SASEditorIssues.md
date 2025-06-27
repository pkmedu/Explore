
##### Problem: Running code in SAS 9.4 Windowing causes the editor window to disappear completely
##### Solutions

First, exit all running SAS sessions.  Then, use Windows Explorer to open the following Windows directory:

C:\Users\pmuhuri\Documents\My SAS Files\9.4

If any of the following files exist in the directory above:

* profile.sas7bcat
* profbak.sas7bcat
* templat.sas7bitm
* profile2.sas7bcat
* regstry.sas7bitm

Rename them to:

* profile.bak
* profbak.bak
* templat.bak
* profile2.bak
* regstry.bak
