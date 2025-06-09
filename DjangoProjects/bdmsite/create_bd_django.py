# -*- coding: utf-8 -*-
"""
Created on Thu May 15 18:25:54 2025

@author: muhuri
"""

import os
import shutil
import subprocess
import sys

# Define project paths
new_project_dir = "C:\\Users\\pmuhuri\\DjangoProjects\\test_django"
project_name = "test_project"
app_name = "test_app"

# Create project directory
if os.path.exists(new_project_dir):
    shutil.rmtree(new_project_dir)
os.makedirs(new_project_dir)
os.chdir(new_project_dir)
print(f"Created directory: {new_project_dir}")

# Create a virtual environment
subprocess.run([sys.executable, "-m", "venv", "venv"], check=True)
print("Created virtual environment")

# Define the Python interpreter in the virtual environment
venv_python = os.path.join(new_project_dir, "venv", "Scripts", "python.exe")

# Install Django
subprocess.run([venv_python, "-m", "pip", "install", "django"], check=True)
print("Installed Django")

# Create a new Django project
subprocess.run([venv_python, "-m", "django", "startproject", project_name], check=True)
print(f"Created Django project: {project_name}")

# Move into the project directory
os.chdir(os.path.join(new_project_dir, project_name))

# Create a new app
subprocess.run([venv_python, "manage.py", "startapp", app_name], check=True)
print(f"Created Django app: {app_name}")

# Update settings.py to include the new app
settings_path = os.path.join(project_name, "settings.py")
with open(settings_path, "r") as f:
    settings_content = f.read()

# Add the app to INSTALLED_APPS
settings_content = settings_content.replace(
    "INSTALLED_APPS = [",
    f"INSTALLED_APPS = [\n    '{app_name}',"
)

with open(settings_path, "w") as f:
    f.write(settings_content)
print(f"Updated {settings_path} to include {app_name}")

# Create a simple model
models_path = os.path.join(app_name, "models.py")
models_content = """from django.db import models

class TestModel(models.Model):
    name = models.CharField(max_length=100)
    
    def __str__(self):
        return self.name
"""

with open(models_path, "w") as f:
    f.write(models_content)
print(f"Updated {models_path} with a simple model")

# Try to run makemigrations
try:
    result = subprocess.run(
        [venv_python, "manage.py", "makemigrations", app_name],
        capture_output=True,
        text=True,
        check=True
    )
    print("Successfully created migrations:")
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print("Failed to create migrations:")
    print(e.stdout)
    print(e.stderr)

# Try to run migrate
try:
    result = subprocess.run(
        [venv_python, "manage.py", "migrate"],
        capture_output=True,
        text=True,
        check=True
    )
    print("Successfully applied migrations:")
    print(result.stdout)
except subprocess.CalledProcessError as e:
    print("Failed to apply migrations:")
    print(e.stdout)
    print(e.stderr)

print("\nTest completed!")
print(f"Test project is available at: {os.path.join(new_project_dir, project_name)}")
print("You can run it with:")
print(f"{venv_python} manage.py runserver")