# -*- coding: utf-8 -*-
"""
Created on Thu May 15 17:56:22 2025

@author: muhuri
"""

import os


# Define the base project directory
# BASE_DIR = r"C:\Users\pmuhuri\DjangoProjects\bdmsite"

# Print the current working directory
print(f"Current directory: {os.getcwd()}")

# List the contents of the current directory
print("\nContents of current directory:")
for item in os.listdir('.'):
    print(f"  {item}")

# Check if bdmsite module exists
bdmsite_dir = os.path.join('.', 'bdmsite')
if os.path.exists(bdmsite_dir) and os.path.isdir(bdmsite_dir):
    print("\nContents of bdmsite directory:")
    for item in os.listdir(bdmsite_dir):
        print(f"  {item}")
else:
    print("\nbdmsite directory not found!")

# Check if bdm_videos module exists
bdm_videos_dir = os.path.join('.', 'bdm_videos')
if os.path.exists(bdm_videos_dir) and os.path.isdir(bdm_videos_dir):
    print("\nContents of bdm_videos directory:")
    for item in os.listdir(bdm_videos_dir):
        print(f"  {item}")
else:
    print("\nbdm_videos directory not found!")