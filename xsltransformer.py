import lxml.etree as ET
import re

# Path to files
xml_file = '/usr/bin/trailer.xml'
xslt_file = '/usr/bin/trailer.xsl'
html_output_file = '/usr/bin/trailer.html'
readme_file = '/usr/bin/README.md'

# Check if XML file exists
try:
    xml = ET.parse(xml_file)
except FileNotFoundError:
    print(f"Error: XML file not found at {xml_file}")
    exit(1)

# Parse XSLT file
try:
    xslt = ET.parse(xslt_file)
except FileNotFoundError:
    print(f"Error: XSLT file not found at {xslt_file}")
    exit(1)

# Transform XML using XSLT
transform = ET.XSLT(xslt)
html = transform(xml)

# Convert HTML to string
html_str = ET.tostring(html, pretty_print=True, method='html').decode('utf-8')
full_url = f"https://georges034302.github.io/trailer-viewer/trailer.html"

# Update the HTML content with the full URL
html_str = html_str.replace('<a href="{view/trailers/link}">Visit Trailer Viewer</a>', f'<a href="{full_url}">Visit Trailer Viewer</a>')

# Write the HTML content to a file
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
