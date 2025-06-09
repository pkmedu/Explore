from django.contrib import admin
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
