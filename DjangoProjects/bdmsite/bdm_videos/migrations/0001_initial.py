
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
