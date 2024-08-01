#!/bin/bash

echo "==================="

# Directory for the repository
REPO_DIR="/tmp/trailer-viewer"

# Clone the repository if not already cloned
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning repository to fetch XML file..."
    git clone https://github.com/Georges034302/trailer-viewer.git $REPO_DIR
else
    echo "Repository already cloned."
fi

# Check if the YAML file exists
if [ ! -f "$REPO_DIR/trailer.yaml" ]; then
    echo "YAML file not found in the cloned repository. Exiting."
    exit 1
fi

# Run trailer.py to generate the XML file
echo "Running trailer.py..."
python3 /usr/bin/trailer.py

# Check if the XML file exists
if [ ! -f "$REPO_DIR/trailer.xml" ]; then
    echo "XML file not found. Exiting."
    exit 1
fi

# Run xsltransformer.py to transform XML and update README.md
echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

# Move the updated README.md and HTML file to the repository directory
echo "Moving updated files..."
mv /tmp/trailer-viewer/trailer.html $REPO_DIR/trailer.html
mv /tmp/trailer-viewer/README.md $REPO_DIR/README.md

# Configure Git with GitHub Actions token
echo "Configuring Git..."
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory $REPO_DIR

# Commit and push changes to the repository
echo "Updating repository..."
cd $REPO_DIR
git add -A
git commit -m "Update trailer HTML and README.md"
git push https://x-access-token:$GITHUB_TOKEN@github.com/Georges034302/trailer-viewer.git

echo "==================="
