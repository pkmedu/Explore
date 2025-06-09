# -*- coding: utf-8 -*-
"""
Created on Thu May 15 17:09:06 2025

@author: muhuri
"""

import os
import shutil
import subprocess
import sys
import random
import string

# Define the base project directory
BASE_DIR = r"C:\Users\pmuhuri\DjangoProjects\bdmsite"

# Function to generate a random Django secret key
def generate_secret_key(length=50):
    chars = string.ascii_letters + string.digits + '!@#$%^&*(-_=+)'
    return ''.join(random.choice(chars) for _ in range(length))

# Function to create a directory if it doesn't exist
def create_dir(path):
    if not os.path.exists(path):
        os.makedirs(path)
        print(f"Created directory: {path}")
    else:
        print(f"Directory already exists: {path}")

# Function to write content to a file
def write_file(path, content):
    with open(path, 'w') as f:
        f.write(content)
    print(f"Created file: {path}")

# Create project structure
def create_project_structure():
    # Create main project directories
    create_dir(BASE_DIR)
    create_dir(os.path.join(BASE_DIR, "bdmsite"))
    create_dir(os.path.join(BASE_DIR, "bdm_videos"))
    create_dir(os.path.join(BASE_DIR, "bdm_videos", "templates"))
    create_dir(os.path.join(BASE_DIR, "bdm_videos", "templates", "bdm_videos"))
    create_dir(os.path.join(BASE_DIR, "templates"))
    create_dir(os.path.join(BASE_DIR, "static"))
    create_dir(os.path.join(BASE_DIR, "staticfiles"))
    create_dir(os.path.join(BASE_DIR, "media"))

    # Create __init__.py files
    write_file(os.path.join(BASE_DIR, "bdmsite", "__init__.py"), "")
    write_file(os.path.join(BASE_DIR, "bdm_videos", "__init__.py"), "")

    # Create settings.py
    settings_content = """import os
from pathlib import Path

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '{}'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['localhost', '127.0.0.1']

# Application definition
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'bdm_videos',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'bdmsite.urls'

TEMPLATES = [
    {{
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {{
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        }},
    }},
]

WSGI_APPLICATION = 'bdmsite.wsgi.application'

# Database
DATABASES = {{
    'default': {{
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }}
}}

# Password validation
AUTH_PASSWORD_VALIDATORS = [
    {{
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    }},
    {{
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    }},
    {{
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    }},
    {{
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    }},
]

# Internationalization
LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

# Static files (CSS, JavaScript, Images)
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, 'static'),
]

# Media files
MEDIA_URL = '/'
MEDIA_ROOT = ''

# Default primary key field type
DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
""".format(generate_secret_key())
    
    write_file(os.path.join(BASE_DIR, "bdmsite", "settings.py"), settings_content)

    # Create urls.py
    urls_content = """from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('bdm_videos.urls')),
]
"""
    write_file(os.path.join(BASE_DIR, "bdmsite", "urls.py"), urls_content)

    # Create wsgi.py
    wsgi_content = """import os
from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bdmsite.settings')

application = get_wsgi_application()
"""
    write_file(os.path.join(BASE_DIR, "bdmsite", "wsgi.py"), wsgi_content)

    # Create asgi.py
    asgi_content = """import os
from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bdmsite.settings')

application = get_asgi_application()
"""
    write_file(os.path.join(BASE_DIR, "bdmsite", "asgi.py"), asgi_content)

    # Create manage.py
    manage_content = """#!/usr/bin/env python
import os
import sys

def main():
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'bdmsite.settings')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    execute_from_command_line(sys.argv)

if __name__ == '__main__':
    main()
"""
    write_file(os.path.join(BASE_DIR, "manage.py"), manage_content)

    # Create bdm_videos app files
    # models.py
    models_content = """from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return self.name
    
    class Meta:
        verbose_name_plural = "Categories"

class Video(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    video_url = models.URLField()
    date_added = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.title
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "models.py"), models_content)

    # views.py
    views_content = """from django.shortcuts import render
from .models import Video, Category

def display_table(request):
    videos = Video.objects.all().order_by('-date_added')
    
    # Create a list of rows for the table
    rows = []
    
    # Header row
    rows.append(['ID', 'Title', 'Category', 'Description', 'Video URL', 'Date Added'])
    
    # Data rows
    for video in videos:
        rows.append([
            video.id,
            video.title,
            video.category.name,
            video.description,
            f'<a href="{video.video_url}" target="_blank">Watch Video</a>',
            video.date_added.strftime('%Y-%m-%d %H:%M')
        ])
    
    return render(request, 'bdm_videos/display_table.html', {'rows': rows})
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "views.py"), views_content)

    # urls.py
    app_urls_content = """from django.urls import path
from . import views

urlpatterns = [
    path('', views.display_table, name='display_table'),
]
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "urls.py"), app_urls_content)

    # admin.py
    admin_content = """from django.contrib import admin
from .models import Category, Video

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'description')
    search_fields = ('name',)

@admin.register(Video)
class VideoAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'video_url', 'date_added')
    list_filter = ('category', 'date_added')
    search_fields = ('title', 'description')
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "admin.py"), admin_content)

    # apps.py
    apps_content = """from django.apps import AppConfig

class BdmVideosConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'bdm_videos'
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "apps.py"), apps_content)

    # Create templates
    # base.html
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
        th {
            padding-top: 12px;
            padding-bottom: 12px;
            background-color: #4CAF50;
            color: white;
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
    write_file(os.path.join(BASE_DIR, "templates", "base.html"), base_html_content)

    # display_table.html
    display_table_content = """{% extends 'base.html' %}

{% block title %}Video Table{% endblock %}

{% block content %}
<h1>Bangladesh Minority Videos</h1>
<p>Total rows: {{ rows|length|add:"-1" }}</p>
<table>
    {% for row in rows %}
        {% if forloop.first %}
            <tr>
                {% for col in row %}
                    <th>{{ col }}</th>
                {% endfor %}
            </tr>
        {% else %}
            <tr>
                {% for col in row %}
                    <td>{{ col|safe }}</td>
                {% endfor %}
            </tr>
        {% endif %}
    {% endfor %}
</table>
{% endblock %}
"""
    write_file(os.path.join(BASE_DIR, "bdm_videos", "templates", "bdm_videos", "display_table.html"), display_table_content)

    print("\nProject structure created successfully!")
    print(f"Change to the project directory: cd {BASE_DIR}")
    print("Run the following commands to set up your database:")
    print("python manage.py makemigrations bdm_videos")
    print("python manage.py migrate")
    print("python manage.py createsuperuser")
    print("python manage.py runserver 8090")
    print("\nAccess your site at: http://127.0.0.1:8090/")
    print("Admin interface at: http://127.0.0.1:8090/admin/")

if __name__ == "__main__":
    create_project_structure()