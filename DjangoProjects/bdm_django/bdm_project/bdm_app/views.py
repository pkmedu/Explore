# In C:\Users\pmuhuri\DjangoProjects\bdm_django\bdm_project\bdm_app\views.py
from django.shortcuts import render, redirect
from datetime import datetime

# Main index view
def index(request):
    # Redirect to the dashboard
    return redirect('dashboard')

# Upload CSV view
def upload_csv(request):
    # Basic implementation - you can enhance this later
    if request.method == 'POST':
        # Handle file upload (placeholder)
        return redirect('dashboard')
    else:
        # Display upload form
        return render(request, 'bdm_app/upload.html')

# Dashboard view
def serve_dashboard(request):
    # Add timestamp
    current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    
    context = {
        'dashboard_timestamp': current_time,
    }
    return render(request, 'bdm_app/dashboard.html', context)

