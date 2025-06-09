# -*- coding: utf-8 -*-
"""
Created on Thu May 15 17:03:06 2025

@author: muhuri
"""

import os
import pathlib

# Define the directory path
templates_dir = r"C:\Users\pmuhuri\DjangoProjects\bdmsite\templates"

# Create the directory if it doesn't exist
if not os.path.exists(templates_dir):
    os.makedirs(templates_dir)
    print(f"Created directory: {templates_dir}")
else:
    print(f"Directory already exists: {templates_dir}")

# Define the content for base.html
base_html_content = """<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{% block title %}Bangladesh Minority Videos{% endblock %}</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div id="content">
        {% block content %}{% endblock %}
    </div>
</body>
</html>
"""

# Create base.html file
base_html_path = os.path.join(templates_dir, "base.html")
with open(base_html_path, "w") as f:
    f.write(base_html_content)
    print(f"Created file: {base_html_path}")

print("Setup complete!")