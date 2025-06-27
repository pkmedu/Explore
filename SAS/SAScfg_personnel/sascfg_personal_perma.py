
import os
os.environ["PATH"] += ";C:\\Program Files\\SASHome\\SASFoundation\\9.4\\core\\sasext"

SAS_config_names=['winlocal']

default  = {'saspath'  : '/opt/sasinside/SASHome/SASFoundation/9.4/bin/sas_u8' }

winlocal = {'java'      : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',  
             'encoding'  : 'windows-1252'
            }


