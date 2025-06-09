# -*- coding: utf-8 -*-
"""
Created on Fri May 16 01:07:48 2025

@author: muhuri
"""

import os
import shutil
from pathlib import Path

def copy_dashboard_file():
    # Source file path
    source_file = r"c:\data\Final_Combined\Combined_all.html"
    
    # Base project directory (where manage.py is located)
    # This line assumes you run the script from your Django project root
    project_root = os.getcwd()
    
    # Target directory path
    target_dir = os.path.join(project_root, "bdm_app", "static", "bdm_app", "dashboards")
    
    # Target file path
    target_file = os.path.join(target_dir, "server_dashboard.html")
    
    # Create the target directory structure if it doesn't exist
    print(f"Creating directory: {target_dir}")
    os.makedirs(target_dir, exist_ok=True)
    
    # Copy the file
    try:
        shutil.copy2(source_file, target_file)
        print(f"Successfully copied file to: {target_file}")
        
        # Provide additional instructions
        print("\nNext steps:")
        print("1. Make sure your settings.py includes static files configuration:")
        print("   STATIC_URL = 'static/'")
        print("   STATICFILES_DIRS = [BASE_DIR / 'static'] # if you have a static folder at project root")
        
        print("\n2. Update your urls.py to serve static files in development:")
        print("   from django.conf import settings")
        print("   from django.conf.urls.static import static")
        print("   urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)")
        
        print("\n3. Access your file at:")
        print("   /static/bdm_app/dashboards/server_dashboard.html")
        
    except FileNotFoundError:
        print(f"Error: Source file not found at {source_file}")
        print("Please check that the file exists at this location.")
    except PermissionError:
        print(f"Error: Permission denied when accessing {source_file} or {target_file}")
        print("Try running the script with administrator privileges.")
    except Exception as e:
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    copy_dashboard_file()