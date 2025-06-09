# Save this as create_favicon.py in your project root
from PIL import Image, ImageDraw, ImageFont
import os

# Create a new image with a white background
img = Image.new('RGB', (32, 32), color=(255, 255, 255))
d = ImageDraw.Draw(img)

# Try to use a built-in font
try:
    font = ImageFont.truetype("arial.ttf", 16)
except IOError:
    font = ImageFont.load_default()

# Draw "BD" in blue
d.text((8, 8), "BD", fill=(0, 0, 255), font=font)

# Save the image
static_dir = os.path.join("static", "images")
os.makedirs(static_dir, exist_ok=True)
img.save(os.path.join(static_dir, "favicon.ico"))

print(f"Favicon created and saved to {os.path.join(static_dir, 'favicon.ico')}")