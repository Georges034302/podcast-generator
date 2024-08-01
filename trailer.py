import yaml
import xml.etree.ElementTree as xml_tree
import os

# Path to YAML file
yaml_file = '/usr/bin/trailer.yaml'

# Path to output XML file
xml_file = '/usr/bin/trailer.xml'

# Check if YAML file exists
if not os.path.exists(yaml_file):
    print(f"Error: YAML file not found at {yaml_file}")
    exit(1)

# Load YAML data
with open(yaml_file, 'r') as file:
    yaml_data = yaml.safe_load(file)
    print("Loaded YAML data:", yaml_data)

# Create XML structure
view_element = xml_tree.Element('view')
trailer_element = xml_tree.SubElement(view_element, 'trailers')

link_prefix = yaml_data['link']
xml_tree.SubElement(trailer_element, 'title').text = yaml_data['title']
xml_tree.SubElement(trailer_element, 'author').text = yaml_data['author']
xml_tree.SubElement(trailer_element, 'description').text = yaml_data['description']
xml_tree.SubElement(trailer_element, 'image', {'href': link_prefix + yaml_data['image']})
xml_tree.SubElement(trailer_element, 'language').text = yaml_data['language']
xml_tree.SubElement(trailer_element, 'format').text = yaml_data['format']
xml_tree.SubElement(trailer_element, 'link').text = link_prefix
xml_tree.SubElement(trailer_element, 'category', {'text': yaml_data['category']})

for item in yaml_data['item']:
    item_element = xml_tree.SubElement(trailer_element, 'item')
    xml_tree.SubElement(item_element, 'title').text = item['title']
    xml_tree.SubElement(item_element, 'description').text = item['description']
    xml_tree.SubElement(item_element, 'released').text = item['released']
    xml_tree.SubElement(item_element, 'duration').text = item['duration']
    enclosure = xml_tree.SubElement(item_element, 'enclosure', {
        'url': link_prefix + item['file'],
        'type': 'video/mp4',
        'size': item['size']
    })

# Write XML to file
output_tree = xml_tree.ElementTree(view_element)
output_tree.write(xml_file, encoding='UTF-8', xml_declaration=True)
print(f'XML file generated: {xml_file}')
