# -*- coding: utf-8 -*-
"""
Created on Thu May 15 17:19:55 2025

@author: muhuri
"""

import os
import sys
import subprocess


# Define the target directory
target_dir = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project"

# Check if the directory exists
if os.path.exists(target_dir) and os.path.isdir(target_dir):
    # Change to the target directory
    os.chdir(target_dir)
    print(f"Successfully changed directory to: {target_dir}")
    print(f"Current working directory: {os.getcwd()}")
    
    # List the contents of the directory
    print("\nContents of the directory:")
    for item in os.listdir('.'):
        if os.path.isdir(item):
            print(f"  📁 {item}/")
        else:
            print(f"  📄 {item}")
else:
    print(f"Error: The directory {target_dir} does not exist.")

def run_command(command):
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True, text=True)
    if result.returncode != 0:
        print(f"Command failed with exit code {result.returncode}")
        return False
    return True

# List of commands to run
commands = [
    "python manage.py makemigrations bdm_app",
    "python manage.py migrate"
    "python manage.py runserver 8090"
]

# Run each command in sequence
for command in commands:
    success = run_command(command)
    if not success:
        print(f"Stopped at command: {command}")
        break