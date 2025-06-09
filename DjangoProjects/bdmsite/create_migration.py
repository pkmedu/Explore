# -*- coding: utf-8 -*-
"""
Created on Thu May 15 18:14:33 2025

@author: muhuri
"""

import os

# Define the base project directory
BASE_DIR = r"C:\Users\pmuhuri\DjangoProjects\bdmsite"


# Ensure migrations directory exists
migrations_dir = 'bdm_videos/migrations'
if not os.path.exists(migrations_dir):
    os.makedirs(migrations_dir)
    print(f"Created directory: {migrations_dir}")

# Create __init__.py in migrations directory
init_py = os.path.join(migrations_dir, '__init__.py')
if not os.path.exists(init_py):
    with open(init_py, 'w') as f:
        pass
    print(f"Created file: {init_py}")

# Create a simple initial migration
initial_migration = os.path.join(migrations_dir, '0001_initial.py')
migration_content = """
from django.db import migrations, models

class Migration(migrations.Migration):
    initial = True
    
    dependencies = []
    
    operations = [
        migrations.CreateModel(
            name='SimpleModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
            ],
        ),
    ]
"""

with open(initial_migration, 'w') as f:
    f.write(migration_content)
print(f"Created file: {initial_migration}")

print("Now try running: python manage.py migrate bdm_videos")