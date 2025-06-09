# -*- coding: utf-8 -*-
"""
Created on Thu May 22 14:46:56 2025

@author: muhuri
"""

import subprocess
import os

venv_python = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv\Scripts\python.exe"

env = os.environ.copy()
env['VIRTUAL_ENV'] = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv"

code = """
import sys
import os
import django
import subprocess

print("Python:", sys.executable)
print("Virtual env:", 'VIRTUAL_ENV' in os.environ)
print("Django:", django.__version__)

result = subprocess.run([sys.executable, "-m", "pip", "list", "--format=freeze"], 
                       capture_output=True, text=True)
packages = result.stdout.strip().split('\\n')
print(f"Installed packages: {len(packages)} total")
for pkg in packages:
    print(f"  - {pkg}")
"""

result = subprocess.run([venv_python, "-c", code], env=env, capture_output=True, text=True)
print(result.stdout)