# -*- coding: utf-8 -*-
"""
Created on Fri May 16 01:24:41 2025

@author: muhuri
"""

import os
import shutil
from pathlib import Path

def copy_dashboard_file():
    # Source file path
    source_file = r"c:\data\Final_Combined\Combined_all.html"
    
    # Project directory structure based on your current setup
    project_root = os.getcwd()  # Assumes you're running from the root where manage.py is
    
    # Path to create static folder structure
    static_dir = os.path.join(project_root, "bdm_app", "static", "bdm_app", "dashboards")
    
    # Target file path
    target_file = os.path.join(static_dir, "server_dashboard.html")
    
    # Create the directory structure
    print(f"Creating directory: {static_dir}")
    try:
        os.makedirs(static_dir, exist_ok=True)
        print(f"Directory created successfully: {static_dir}")
    except Exception as e:
        print(f"Error creating directory: {str(e)}")
        return
    
    # Copy the file
    try:
        if not os.path.exists(source_file):
            print(f"Error: Source file not found at {source_file}")
            return
            
        shutil.copy2(source_file, target_file)
        print(f"Successfully copied file to: {target_file}")
        
        # Display current directory structure
        print("\nUpdated directory structure:")
        for root, dirs, files in os.walk(os.path.join(project_root, "bdm_app", "static")):
            level = root.replace(project_root, '').count(os.sep)
            indent = ' ' * 4 * level
            print(f"{indent}{os.path.basename(root)}/")
            sub_indent = ' ' * 4 * (level + 1)
            for file in files:
                print(f"{sub_indent}{file}")
                
        # Instructions for Django settings
        print("\nNext steps:")
        print("1. Add this to your bdm_project/settings.py:")
        print("   STATIC_URL = 'static/'")
        print("   STATICFILES_DIRS = [")
        print("       BASE_DIR / 'bdm_app' / 'static',")
        print("   ]")
        print("   STATIC_ROOT = BASE_DIR / 'staticfiles'")
        
        print("\n2. Add this to your bdm_project/urls.py:")
        print("   from django.conf import settings")
        print("   from django.conf.urls.static import static")
        print("   ")
        print("   if settings.DEBUG:")
        print("       urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)")
        
        print("\n3. Access your file at:")
        print("   /static/bdm_app/dashboards/server_dashboard.html")
        
    except PermissionError:
        print(f"Error: Permission denied when accessing {source_file} or {target_file}")
        print("Try running the script with administrator privileges.")
    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    copy_dashboard_file()