
* List all filenames with the extension SAS from a folder;
PROC IML;
SUBMIT / R;
setwd ("C:/Data")

#identify the folders
fromFolder <- "c:/Data"
toFolder <- "C:/R_pgms_set1"

# find the list of files to copy
 list.of.files <- list.files(fromFolder, ".R$", ignore.case=TRUE)

# print objects
print(c(fromFolder, toFolder, list.of.files))
options(warn=1)

# copy the files to the toFolder 

file.copy(file.path(fromFolder,list.of.files), toFolder, overwrite=TRUE)

ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/R_pgms_set1')  # Set working directory
myDir <- 'c:/R_pgms_set1'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'R_pgmsZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/SAS_pgms_set1')  # Set working directory
myDir <- 'c:/SAS_pgms_set1'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'SAS_pgmsZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/SASCodeExplanation')  # Set working directory
myDir <- 'c:/SASCodeExplanation'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'SASCodeExplanationZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/SESUG2024_Python')  # Set working directory
myDir <- 'c:/SESUG2024_Python'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'SESUG2024_PythonZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/Python')  # Set working directory
myDir <- 'c:/Python'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'PythonZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;


PROC IML;
SUBMIT / R;
setwd('c:/SAS_Treasure')  # Set working directory
myDir <- 'c:/SAS_Treasure'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'SAS_TreasureZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;


PROC IML;
SUBMIT / R;
setwd('c:/MEPSExercisesSDOH')  # Set working directory
myDir <- 'c:/MEPSExercisesSDOH'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'MEPSExercisesSDOHZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/Inapp')  # Set working directory
myDir <- 'c:/Inapp'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'Inappp', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

PROC IML;
SUBMIT / R;
setwd('c:/USC')  # Set working directory
myDir <- 'c:/USC'  # Define directory path
files2zip <- dir(myDir, full.names = TRUE)  # Use the variable myDir without quotes
setwd('c:/bdata')  # Change directory for saving the zip file
zip(zipfile = 'USCZip', files = files2zip)  # Create the zip file
ENDSUBMIT;
QUIT;

