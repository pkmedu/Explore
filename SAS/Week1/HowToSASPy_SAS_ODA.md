
## How to Connect SASPy with SAS ODA (SAS 9.4 M7)

I assume that you can access SAS ODA from your computer. To connect SASPy with SAS ODA, you must install the following software or packages as a prerequisite for SASPy installation. Anaconda and SAS kernel installations will also be required.

#### Step 1: Add _authinfo file 
[How To create an Authinfo file and where to store it](https://documentation.sas.com/api/docsets/authinfo/9.4/content/authinfo.pdf?locale=en)

```ascii
C:\Users\rblack\_authinfo
```
In the _authinfo file, add the following line.
```
oda user youremailaddress password yourpassword
```
#### Step 2: Store the following .jar files in the IOM Client

ODA has recently been upgraded to SAS 9.4M7, and that release requires the 3 encryption jars in the IOM Client, which SASPy uses to communicate with SAS workspace servers. So you'll need to add those to the saspy deployment. 
[The instructions for that are here.](https://sassoftware.github.io/saspy/configuration.html#attn-as-of-saspy-version-3-3-3-the-classpath-is-no-longer-required-in-your-configuration-file)

[The three files are stored in GW Box.](https://gwu.app.box.com/folder/247261307655?s=g6ezxpoy5qwy84wk6mhtr37qobgogl0s)
```
sas.rutil.jar
sas.rutil.jar
sastpj.rutil.jar
```
Copy them to the following folder paths.
```ascii
C:\Program Files\SASHome\SASVersionedJarRepository\eclipse\plugins\sas.rutil_904600.0.0.20181017190000_v940m6\sas.rutil.jar

C:\Program Files\SASHome\SASVersionedJarRepository\eclipse\plugins\sas.rutil.nls_904400.0.0.20160427190000_v940m4\sas.rutil.nls.jar

C:\Program Files\SASHome\SASVersionedJarRepository\eclipse\plugins\sastpj.rutil_6.1.0.0_SAS_20121211183517\sastpj.rutil.jar
```
#### Step 3:[Install Anaconda on Windows](https://www.geeksforgeeks.org/how-to-install-anaconda-on-windows/)
Jupyter Notebook automatically gets installed as part of the Anaconda installation
	
 #### Step 4: [Download Java for Windows](https://www.java.com/download/ie_manual.jsp) or [for macOS](https://www.java.com/en/download/apple.jsp) as appropriate

 #### Step 5: Install SASPy
 
 * Open the following URL with your web browser: https://github.com/sassoftware/saspy/releases

 * At the top of this page, you should see that the current release of SASPy is: V4.3.2 (for example)

 * Then scroll down just a bit until you see the heading titled: Assets

 * If you click the following link: Source code (tar.gz), it should download a local copy of the 
following installation file: saspy-4.3.2.tar.gz or an updated version.

 * Once you do this, you should be able to install this or an updated version via the following PIP command then: 
```
	pip install C:\your\directory\saspy-4.3.2.tar.gz

```
	Where "C:\your\directory" is the location on your machine where saspy-4.3.2.tar.gz resides. 

 * After installing SASPy you can verify the installation by issuing the following command: 
```
	pip show saspy
```
#### Step 6: Install the SAS kernel. 

So the SAS kernel is a separate install from the SASPy install. Typically, to install the SAS kernel, you simply issue the following command:
```
	pip install sas-kernel
```
But if you try this and run into the SSL certificate issue as before, try the following.
Open the following URL with your web browser: https://github.com/sassoftware/sas_kernel/releases 

Near the top of this page, under Assets, click the following link: Source code (tar.gz). It should download a local copy of the following installation file: sas_kernel-2.4.11.tar.gz or an updated version.

Once you do this, you should be able to install this via the following PIP command then: 

```
	pip install C:\your\directory\sas_kernel-2.4.11.tar.gz
```
Where "C:\your\directory" is the location on your machine where sas_kernel-2.4.11.tar.gz resides. 

After installing the SAS kernel, you can verify the installation by issuing the following command: 
```
	pip show sas-kernel
```
SASPy does not require the SAS kernel, but the SAS kernel does require SASPy to be installed.


[SASPy and the SAS kernel for Jupyter Notebook enable you to connect to SAS® 9.4 and the SAS® Viya®." (Mincey, 2022)](https://blogs.sas.com/content/sgf/2022/04/18/saspy-and-the-sas-kernel-for-jupyter-notebook/)

#### Step 7: Create a sascfg_personal.py and store it in the saspy folder to connect SASPy to your SAS installation. 

##### Example folder
```ascii
C:\Users\rblack\AppData\Local\anaconda3\Lib\site-packages\saspy\sascfg_personal.py
```
##### Content of sascfg_personal.py

```python
SAS_config_names=['oda']
oda = {'java' : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',
#US Home Region 2
'iomhost' : ['odaws01-usw2-2.oda.sas.com','odaws02-usw2-2.oda.sas.com'],
'iomport' : 8591,
'authkey' : 'oda',
'encoding' : 'utf-8'
}
```
 After installing and configuring SASPy and connecting SAS with setup from Jupyter Notebook, you can use SAS and Python.

##### Step 8: Check if sascfg_personal.py connects SASPy to your SAS ODA
```python
import saspy
sas = saspy.SASsession()
sas
```

##### Step 9: Check if the following Python code using the SAS kernel works
```
import saspy
import pandas as pd
sas = saspy.SASsession()
w_class = sas.sasdata("CLASS","SASHELP")
w_class.describe()
```

