# -*- coding: utf-8 -*-
"""
Created on Thu May 15 19:13:03 2025

@author: muhuri
"""

import os

# Set the correct path
project_root = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project"
settings_path = os.path.join(project_root, "bdm_project", "settings.py")

if os.path.exists(settings_path):
    print(f"Found settings.py at: {settings_path}")
    print(f"Contents of {settings_path}:")
    with open(settings_path, "r") as f:
        settings_content = f.read()
        print(settings_content)
        
    # Check if bdm_videos is referenced instead of bdm_app
    if "bdm_videos" in settings_content:
        print("\nFound 'bdm_videos' in settings.py, updating to 'bdm_app'...")
        updated_content = settings_content.replace("bdm_videos", "bdm_app")
        
        with open(settings_path, "w") as f:
            f.write(updated_content)
        print("Updated settings.py")
    else:
        print("\nNo references to 'bdm_videos' found in settings.py")
else:
    print(f"Error: Settings file not found at {settings_path}")
    
    # Let's try to find where the settings.py file is located
    print("\nSearching for settings.py file in the project directory...")
    
    for root, dirs, files in os.walk(r"C:\Users\pmuhuri\DjangoProjects\bdm_django"):
        for file in files:
            if file == "settings.py":
                found_path = os.path.join(root, file)
                print(f"Found settings.py at: {found_path}")

