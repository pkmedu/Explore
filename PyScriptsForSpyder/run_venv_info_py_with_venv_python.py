# -*- coding: utf-8 -*-
"""
Created on Thu May 22 14:32:19 2025

@author: muhuri
"""

import subprocess
import os

venv_python = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv\Scripts\python.exe"

# Set up environment
env = os.environ.copy()
env['VIRTUAL_ENV'] = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv"
env['PATH'] = r"C:\Users\pmuhuri\DjangoProjects\bdm_django\venv\Scripts" + os.pathsep + env.get('PATH', '')
env['PYTHONIOENCODING'] = 'utf-8'

# Simple diagnostic code
diagnostic_code = """
import os
import sys

print("=" * 60)
print("VIRTUAL ENVIRONMENT DIAGNOSTIC")
print("=" * 60)

print(f"Python executable: {sys.executable}")
print(f"Virtual environment active: {'VIRTUAL_ENV' in os.environ}")

if 'VIRTUAL_ENV' in os.environ:
    print(f"Virtual environment path: {os.environ['VIRTUAL_ENV']}")
    print("Status: [OK] Virtual environment properly activated!")
else:
    print("Status: [ERROR] Virtual environment not activated")

# Test Django
try:
    import django
    print(f"Django: {django.__version__} [OK]")
    
    # Test Django configuration
    from django.conf import settings
    if not settings.configured:
        settings.configure(DEBUG=True, SECRET_KEY='test-key')
        print("Django configuration: [OK]")
        
except ImportError as e:
    print(f"Django: [ERROR] {e}")
except Exception as e:
    print(f"Django config: [ERROR] {e}")

# Show installed packages
try:
    import subprocess as sp
    result = sp.run([sys.executable, "-m", "pip", "list", "--format=freeze"], 
                   capture_output=True, text=True)
    if result.returncode == 0:
        packages = result.stdout.strip().split()
        print(f"Installed packages: {len(packages)} total")
        for pkg in packages[:5]:  # Show first 5
            print(f"  - {pkg}")
        if len(packages) > 5:
            print(f"  ... and {len(packages)-5} more")
    else:
        print("Package list: [ERROR] Could not retrieve")
except Exception as e:
    print(f"Package check: [ERROR] {e}")

print("=" * 60)
"""

print("Running diagnostic...")
try:
    result = subprocess.run([venv_python, "-c", diagnostic_code], 
                           env=env, capture_output=True, text=True, encoding='utf-8')
    
    print(result.stdout)
    
    if result.stderr:
        print("Errors:")
        print(result.stderr)
        
    if result.returncode == 0:
        print("[SUCCESS] Diagnostic completed!")
    else:
        print(f"[WARNING] Exit code: {result.returncode}")
        
except Exception as e:
    print(f"[ERROR] Failed to run script: {e}")