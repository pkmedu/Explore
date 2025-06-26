# -*- coding: utf-8 -*-
"""
Created on Sat May 17 19:10:54 2025

@author: muhuri
"""

import os
import sys
import subprocess
import django

# Set up Django environment
sys.path.append('C:/Explore/DjangoProjects/bdm_django/bdm_project')
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bdm_project.settings')
django.setup()

# Path to your virtual environment's Python executable
venv_python = r"C:\Explore\DjangoProjects\bdm_django\venv\Scripts\python.exe"

# Path to your manage.py
manage_py = r"C:\Explore\DjangoProjects\bdm_django\bdm_project\manage.py"

# Function to run Django management commands
def run_command(command):
    print(f"Running: {' '.join(command)}")
    process = subprocess.Popen(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        universal_newlines=True
    )
    
    # Print output in real-time
    for line in process.stdout:
        print(line, end='')
    
    # Wait for process to complete
    process.wait()
    print(f"Command completed with exit code: {process.returncode}")
    return process.returncode

# Step 1: Make migrations
print("STEP 1: Making migrations")
run_command([venv_python, manage_py, "makemigrations", "bdm_app"])

# Step 2: Apply migrations
print("\nSTEP 2: Applying migrations")
run_command([venv_python, manage_py, "migrate"])

print("\nMigration process completed!")