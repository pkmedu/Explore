
SAS_config_names=['oda', 'winlocal']

oda = {'java' : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',
#US Home Region 1
'iomhost' : ['odaws01-usw2.oda.sas.com','odaws02-usw2.oda.sas.com','odaws03-usw2.oda.sas.com','odaws04-usw2.oda.sas.com'],
'iomport' : 8591,
'authkey' : 'oda',
'encoding' : 'utf-8'
}


winlocal    = {'java'      : 'C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe',
            }

default  = {'saspath'  : '/opt/sasinside/SASHome/SASFoundation/9.4/bin/sas_u8'
            }

# build out a local classpath variable to use below for Windows clients   CHANGE THE PATHS TO BE CORRECT FOR YOUR INSTALLATION 
cpW  =  "C:\\Program Files\\SASHome\\SASDeploymentManager\\9.4\\products\\deploywiz__94582__prt__xx__sp0__1\\deploywiz\\sas.svc.connection.jar"
cpW += ";C:\\Program Files\\SASHome\\SASDeploymentManager\\9.4\\products\\deploywiz__94582__prt__xx__sp0__1\\deploywiz\\log4j.jar"
cpW += ";C:\\Program Files\\SASHome\\SASDeploymentManager\\9.4\\products\\deploywiz__94582__prt__xx__sp0__1\\deploywiz\\sas.security.sspi.jar"
cpW += ";C:\\Program Files\\SASHome\\SASDeploymentManager\\9.4\\products\\deploywiz__94582__prt__xx__sp0__1\\deploywiz\\sas.core.jar"
cpW += ";C:\\Users\\pmuhuri\\anaconda3\\New folder\\Lib\\site-packages\\saspy\\java\\saspyiom.jar"

winlocal = {'java'      : 'java',
            'encoding'  : 'windows-1252',
            'classpath' : cpW
            }



