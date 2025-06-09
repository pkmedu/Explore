# -*- coding: utf-8 -*-
"""
Created on Thu May 15 18:09:39 2025

@author: muhuri
"""

import os

# Define the directories where __init__.py should exist
dirs_needing_init = [
    'bdmsite',
    'bdm_videos',
    'bdm_videos/migrations'
]

# Create __init__.py files
for dir_path in dirs_needing_init:
    init_file = os.path.join(dir_path, '__init__.py')
    if not os.path.exists(init_file):
        with open(init_file, 'w') as f:
            # Create an empty file
            pass
        print(f"Created {init_file}")
    else:
        print(f"{init_file} already exists")

# Also check the content of the migrations directory
migrations_dir = 'bdm_videos/migrations'
if os.path.exists(migrations_dir) and os.path.isdir(migrations_dir):
    print("\nContents of migrations directory:")
    for item in os.listdir(migrations_dir):
        print(f"  {item}")