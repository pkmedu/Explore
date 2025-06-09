# -*- coding: utf-8 -*-
"""
Created on Thu May 15 23:40:10 2025

@author: muhuri
"""

import os
import subprocess

# Change to the project directory
os.chdir(r"C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project")

# Run the Django createsuperuser command
venv_python = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv\Scripts\python.exe"
subprocess.run([venv_python, "manage.py", "createsuperuser"])