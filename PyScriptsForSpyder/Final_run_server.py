# -*- coding: utf-8 -*-
"""
Created on Thu May 15 22:46:57 2025

@author: muhuri
"""
# Comments

"""
This script runs a Django development server from within a Python script (like in Spyder) 
using your virtual environment's Python interpreter. Let me walk through what it does:

Imports subprocess and os modules
Changes the working directory to your Django project directory using os.chdir()
Defines the path to the Python executable in your virtual environment
Starts the Django development server on port 8090 using subprocess.Popen()
Captures and prints the output in real-time

A few things to note:

The code uses subprocess.Popen() with stdout/stderr capturing to show server output in your console
Port 8090 is specified (instead of the default 8000)
The code assumes your virtual environment is in the project folder

If you run this code in Spyder, you should see the Django server start up and print its output in the console. You can then access your Django site at http://127.0.0.1:8090/ in your web browser.

http://127.0.0.1:8090/
"""

import subprocess
import os
import datetime
import re

# Change to the project directory
os.chdir(r"C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project")

# Define the path to your virtual environment Python
venv_python = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv\Scripts\python.exe"

# Run the Django development server
process = subprocess.Popen([venv_python, "manage.py", "runserver", "8090"], 
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT,
                           universal_newlines=True)

# Pattern to match Django's timestamp format
django_timestamp_pattern = re.compile(r'\[\d+/\w+/\d+ \d+:\d+:\d+\] ')

# Print output in real-time with custom timestamps
print(f"[{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}] Django server starting on port 8090...")
for line in process.stdout:
    # Remove Django's timestamp if present
    clean_line = django_timestamp_pattern.sub('', line)
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    print(f"[{timestamp}] {clean_line}", end='')


    
   