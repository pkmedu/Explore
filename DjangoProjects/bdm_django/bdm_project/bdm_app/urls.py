# In C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project\bdm_app\urls.py

from django.urls import path
from . import views

urlpatterns = [
    # Main index page
    path('', views.index, name='index'),
    
    # Upload CSV page
    path('upload/', views.upload_csv, name='upload_csv'),
    
    # Dashboard page
    path('dashboard/', views.serve_dashboard, name='dashboard'),
]

