# -*- coding: utf-8 -*-
"""
Created on Mon May 19 18:20:18 2025

@author: muhuri
"""

import os
import sys
import subprocess
import site

def get_venv_info():
    # Basic information
    print(f"Python Executable: {sys.executable}")
    print(f"Python Version: {sys.version}")
    print(f"Virtual Environment: {'VIRTUAL_ENV' in os.environ}")
    
    if 'VIRTUAL_ENV' in os.environ:
        print(f"Virtual Environment Path: {os.environ['VIRTUAL_ENV']}")
    else:
        # Try to detect venv even if not activated
        base_prefix = getattr(sys, "base_prefix", None) or getattr(sys, "real_prefix", None) or sys.prefix
        if base_prefix != sys.prefix:
            print(f"Virtual Environment detected (not activated). Base: {base_prefix}")
            print(f"Current Environment: {sys.prefix}")
    
    # Site packages
    print(f"\nSite-packages directories:")
    for path in site.getsitepackages():
        print(f"  - {path}")
    
    # Installed packages
    print("\nInstalled packages:")
    try:
        result = subprocess.run([sys.executable, "-m", "pip", "list"], 
                               capture_output=True, text=True, check=True)
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error getting package list: {e}")
        
    # Environment variables
    print("\nRelevant environment variables:")
    for key in ['PYTHONPATH', 'VIRTUAL_ENV', 'PATH']:
        if key in os.environ:
            if key == 'PATH':
                print(f"{key}: (first few entries)")
                paths = os.environ[key].split(os.pathsep)
                for p in paths[:3]:  # Show just first 3 path entries
                    print(f"  - {p}")
                print(f"  ... ({len(paths)-3} more entries)")
            else:
                print(f"{key}: {os.environ[key]}")

if __name__ == "__main__":
    get_venv_info()
    