import lxml.etree as ET
import re
import os

# Define paths
xml_file = '/tmp/trailer-viewer/trailer.xml'
xslt_file = '/usr/bin/trailer.xsl'
html_output_file = '/tmp/trailer-viewer/trailer.html'
readme_file = '/tmp/trailer-viewer/README.md'

# Check if XML file exists
if not os.path.isfile(xml_file):
    raise FileNotFoundError(f"XML file not found at {xml_file}")

# Parse XML and XSLT files
try:
    xml = ET.parse(xml_file)
except ET.XMLSyntaxError as e:
    raise RuntimeError(f"Error parsing XML file: {e}")

try:
    xslt = ET.parse(xslt_file)
except ET.XMLSyntaxError as e:
    raise RuntimeError(f"Error parsing XSLT file: {e}")

# Transform XML using XSLT
try:
    transform = ET.XSLT(xslt)
    html = transform(xml)
except Exception as e:
    raise RuntimeError(f"Error during XSLT transformation: {e}")

# Convert the HTML to string and append the base URL to links
html_str = ET.tostring(html, pretty_print=True, method='html').decode('utf-8')

# Extract the base URL from the XML file
base_url = xml.findtext('trailers/link')
full_url = f"{base_url.rstrip('/')}/trailer.html"

# Update the HTML content with the full URL
html_str = html_str.replace('<a href="{view/trailers/link}">Visit Trailer Viewer</a>', f'<a href="{full_url}">Visit Trailer Viewer</a>')

# Write the updated HTML content to a file
with open(html_output_file, 'w') as f:
    f.write(html_str)

# Function to update README.md with the latest URL
def update_readme(readme_file, new_url):
    # Ensure README.md exists
    if not os.path.isfile(readme_file):
        raise FileNotFoundError(f"README.md not found at {readme_file}")

    # Read the existing README.md
    with open(readme_file, 'r') as f:
        content = f.read()

    # Define the marker and URL pattern
    marker = "[Latest Trailers URL]"
    url_pattern = f"You can view the trailers [here]({new_url})."

    # Remove any existing URL entries and marker
    content = re.sub(rf'{re.escape(marker)}\s*[\s\S]*?(?=\n\S|$)', '', content).rstrip()

    # Ensure there's exactly one blank line before the URL
    if not content.endswith('\n\n'):
        content += '\n\n'

    # Append the new URL and marker
    content += f"{marker}\n{url_pattern}\n"

    # Write the updated content back to README.md
    with open(readme_file, 'w') as f:
        f.write(content)

# Update README.md with the new URL
update_readme(readme_file, full_url)

print(f'HTML file generated: {html_output_file}')
print(f'Full URL appended to README.md: {full_url}')
