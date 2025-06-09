from django.shortcuts import render
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
