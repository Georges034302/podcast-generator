import lxml.etree as ET
import re
import os

# Define paths
xml_file = '/tmp/trailer-viewer/trailer.xml'  # Path where trailer.xml is expected
xslt_file = '/usr/bin/trailer.xsl'
html_output_file = '/tmp/trailer-viewer/trailer.html'  # Path to save the HTML output
readme_file = '/tmp/trailer-viewer/README.md'  # Path to the README.md file

# Check if XML file exists
if not os.path.isfile(xml_file):
    raise FileNotFoundError(f"XML file not found at {xml_file}")

# Parse XML and XSLT files
xml = ET.parse(xml_file)
xslt = ET.parse(xslt_file)
transform = ET.XSLT(xslt)

# Transform XML using XSLT
html = transform(xml)

# Convert the HTML to string and update links
html_str = ET.tostring(html, pretty_print=True, method='html').decode('utf-8')
base_url = xml.findtext('trailers/link').rstrip('/')
full_url = f"{base_url}/trailer.html"
html_str = html_str.replace('<a href="{view/trailers/link}">Visit Trailer Viewer</a>', f'<a href="{full_url}">Visit Trailer Viewer</a>')

# Write the updated HTML content to a file
with open(html_output_file, 'w') as f:
    f.write(html_str)

# Function to update README.md with the latest URL
def update_readme(readme_file, new_url):
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
