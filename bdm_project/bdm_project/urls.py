from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static
from django.views.static import serve
from django.views.generic import RedirectView  # Add this import

urlpatterns = [
    path('admin/', admin.site.urls),
    path('bdm_app/', include('bdm_app.urls')),
    
    # Add this line to redirect the root URL to your app
    path('', RedirectView.as_view(url='bdm_app/', permanent=False), name='home'),
    
    # Your fixed static patterns
    re_path(r'^static/(?P<path>.*)$', serve, {'document_root': settings.STATIC_ROOT}),
    path('static/<path:path>', serve, {'document_root': settings.STATIC_ROOT}),
]

# Add this if it's not already present
if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)