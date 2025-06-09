# In C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project\bdm_app\admin.py
from django.contrib import admin
from .models import Category, Video

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name',)
    search_fields = ('name',)

@admin.register(Video)
class VideoAdmin(admin.ModelAdmin):
    list_display = ('title', 'category', 'video_url')
    list_filter = ('category',)
    search_fields = ('title',)