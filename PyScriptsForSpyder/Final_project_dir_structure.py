# -*- coding: utf-8 -*-
"""
Created on Fri May 16 00:35:51 2025

@author: muhuri
"""

import os
from pathlib import Path

def print_directory_structure(start_path, indent=0):
    """
    Print the directory structure starting from the given path.
    
    Args:
        start_path (str): The starting directory path.
        indent (int): The current indentation level for formatting.
    """
    # Get the base directory name for the initial call
    if indent == 0:
        print(f"{os.path.basename(start_path)}/")
    
    # List all files and directories in the current path
    try:
        entries = os.listdir(start_path)
        entries.sort()  # Sort entries alphabetically
        
        for entry in entries:
            entry_path = os.path.join(start_path, entry)
            
            # Check if the entry is a directory
            if os.path.isdir(entry_path):
                # Print directory name with proper indentation
                print("│   " * indent + "├── " + entry + "/")
                # Recursively print subdirectories
                print_directory_structure(entry_path, indent + 1)
            else:
                # Print file name with proper indentation
                print("│   " * indent + "├── " + entry)
    except PermissionError:
        print("│   " * indent + "├── [Permission Denied]")
    except Exception as e:
        print("│   " * indent + f"├── [Error: {str(e)}]")

# Path to your project
project_path = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project"

# Print the directory structure
print("Directory structure:")
print_directory_structure(project_path)