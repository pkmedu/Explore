
## How to connect SASPy with a Local Installation of SAS

I assume you can access a local installation of SAS (i.e., licensed SAS) on your computer. As a prerequisite for SASPy installation, you must download/install Anaconda and download Java to connect SASPy with a local installation of the Licensed version of SAS.

 #### Step 1: [Install Anaconda on Windows](https://www.geeksforgeeks.org/how-to-install-anaconda-on-windows/)
Jupyter Notebook automatically gets installed as part of the Anaconda installation.
	
 #### Step 2: [Download Java for Windows](https://www.java.com/download/ie_manual.jsp) or [for macOS](https://www.java.com/en/download/apple.jsp) as appropriate

 #### Step 3: Download and install SASPy
 
 * Open this URL(https://github.com/sassoftware/saspy/releases) with a web browser

 * At the top of this page, you should see that the current release of SASPy

 * Then scroll down just a bit until you see the heading titled: Assets. Clicking it should download a local copy of the 
installation file.

 * Then you should be able to install the downloaded version via the following PIP command: 
```
	pip install C:\your\directory\saspy-4.3.2.tar.gz

```
	Where "C:\your\directory" is the location on your machine where saspy-4.3.2.tar.gz resides. 

 * After installing SASPy you can verify the installation by issuing the following command: 
```
	pip show saspy
```
#### Step 4: Install the SAS kernel. 

So the SAS kernel is a separate install from the SASPy install. Typically, to install the SAS kernel, you simply issue the following command:
```
	pip install sas-kernel
```
But if you try this and run into the SSL certificate issue as before, try the following.
Open the following URL with your web browser: https://github.com/sassoftware/sas_kernel/releases 

Near the top of this page, under Assets, click the following link: Source code (tar.gz). It should download a local copy of an installation file (e.g., sas_kernel-2.4.11.tar.gz or an updated version).

Install the file via the following PIP command then: 

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

#### Step 5: Create a sascfg_personal.py and store it in the saspy folder to connect SASPy to your SAS installation. 

#### [Installing SASPy Kernel for Jupyter Notebooks and Jupyter Lab](https://communities.sas.com/t5/SAS-Communities-Library/Installing-SASPy-Kernel-for-Jupyter-Notebooks-and-Jupyter-Lab/ta-p/464873)

##### Example folder
```ascii
C:\Users\rblack\AppData\Local\anaconda3\Lib\site-packages\saspy\sascfg_personal.py
```
##### Content of sascfg_personal.py
```python
import os
os.environ["PATH"] += ";C:\\Program Files\\SASHome\\SASFoundation\\9.4\\core\\sasext"
SAS_config_names=['winlocal']
default  = {'saspath'  : '/opt/sasinside/SASHome/SASFoundation/9.4/bin/sas_u8' }
winlocal = {'java'      : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',  'encoding'  : 'windows-1252'}

```

##### Step 6: Check if sascfg_personal.py connects SASPy to your SAS installations

```python
import saspy
sas = saspy.SASsession()
sas
```

##### Step 7: Check if the following Python code using the SAS kernel works
```
import saspy
import pandas as pd
sas = saspy.SASsession(cfgname='winlocal')
w_class = sas.sasdata("CLASS","SASHELP")
w_class.describe()
```
 ##### Some Facts about SASPy 
 
 * It enables communication between Jupyter and SAS when using the SAS Kernel.

 * It can run Python code using a commonly used IDE other than Jupyter Notebook. 
 
 * It can load SAS data sets into Python-Pandas DataFrame objects. 
 
 * It converts Python-Pandas DataFrame objects into SAS data sets. 
 
 * It uses Python convenience methods on SAS data sets. 
 
 * It imitates the SAS macro facility. 
 
 * It generates SAS code from Python code. 
 
 * It enables you to inject your SAS program code from within a Python language notebook using special Jupyter "magics" supported by the sas_kernel and pull in SAS results. This %%SAS magic command allows you to move quickly between Python and SAS in a single environment (Hemedinger, 2016).
 
 * It provides output with several options: HTML, Text, and Pandas data frame. 

##### pip commands to uninstall/install saspy and sas_kernel

```
pip install 
pip uninstall -y saspy 
pip uninstall -y sas_kernel 
pip install saspy 
sas_kernel 
pip show saspy 
```
