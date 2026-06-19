"""
# The code snippets (SAS configuration file for SASPy) below are for SAS ODA and have been commented out because I am using SAS 9.4 (licensed software) for now.
SAS_config_names=['oda']
oda = {'java' : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',
US Home Region 2
'iomhost' : ['odaws01-usw2.oda.sas.com','odaws02-usw2.oda.sas.com','odaws03-usw2.oda.sas.com','odaws04-usw2.oda.sas.com'], 
'iomport' : 8591,
'authkey' : 'oda',
'encoding' : 'utf-8'
}
"""

# The code snippets (SAS configuration file for SASPy) below are for SAS 9.4 (licensed software)

import os
os.environ["PATH"] += ";C:\\Program Files\\SASHome\\SASFoundation\\9.4\\core\\sasext"
SAS_config_names=['winlocal']
default  = {'saspath'  : '/opt/sasinside/SASHome/SASFoundation/9.4/bin/sas_u8' }
winlocal = {'java'      : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',  'encoding'  : 'windows-1252'}
