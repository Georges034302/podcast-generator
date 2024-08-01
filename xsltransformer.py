import lxml.etree as ET
import re
import os

# Define paths relative to the current working directory
xml_file = 'trailer.xml'
xslt_file = 'trailer.xsl'
html_output_file = 'trailer.html'
readme_file = 'README.md'

# Function to check if a file exists and print an error message if it does not
def check_file_exists(file_path):
    if not os.path.exists(file_path):
        print(f"Error: File not found at {file_path}")
        exit(1)

# Check if XML and XSLT files exist
check_file_exists(xml_file)
check_file_exists(xslt_file)

# Parse XML and XSLT files
try:
    xml = ET.parse(xml_file)
    xslt = ET.parse(xslt_file)
except ET.XMLSyntaxError as e:
    print(f"Error parsing XML/XSLT: {e}")
    exit(1)

# Transform XML using XSLT
try:
    transform = ET.XSLT(xslt)
    html = transform(xml)
except Exception as e:
    print(f"Error during XSLT transformation: {e}")
    exit(1)

# Convert HTML to string
html_str = ET.tostring(html, pretty_print=True, method='html').decode('utf-8')

# Full URL to be used in the README.md file
full_url = "https://georges034302.github.io/trailer-viewer/trailer.html"

# Update the HTML content with the full URL
html_str = html_str.replace('<a href="{view/trailers/link}">Visit Trailer Viewer</a>', f'<a href="{full_url}">Visit Trailer Viewer</a>')

# Write the HTML content to a file
try:
    with open(html_output_file, 'w') as f:
        f.write(html_str)
    print(f'HTML file generated: {html_output_file}')
except Exception as e:
    print(f"Error writing HTML file: {e}")
    exit(1)

# Function to update README.md with the latest URL
def update_readme(readme_file, new_url):
    if not os.path.exists(readme_file):
        print(f"Error: README.md not found at {readme_file}")
        return

    try:
        with open(readme_file, 'r') as f:
            content = f.read()
    except Exception as e:
        print(f"Error reading README.md: {e}")
        exit(1)

    marker = "[Latest Trailers URL]"
    url_pattern = f"You can view the trailers [here]({new_url})."
    content = re.sub(rf'{re.escape(marker)}\s*[\s\S]*?(?=\n\S|$)', '', content).rstrip()
    if not content.endswith('\n\n'):
        content += '\n\n'
    content += f"{marker}\n{url_pattern}\n"

    try:
        with open(readme_file, 'w') as f:
            f.write(content)
    except Exception as e:
        print(f"Error writing to README.md: {e}")
        exit(1)

update_readme(readme_file, full_url)
