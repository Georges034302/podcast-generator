#!/bin/bash

echo "==================="

# Set environment variables
echo "GITHUB_ACTOR: ${GITHUB_ACTOR}"
echo "INPUT_EMAIL: ${INPUT_EMAIL}"

# Clone the repository if not already cloned
REPO_DIR="/tmp/trailer-viewer"
if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning repository to fetch XML file..."
    git clone https://github.com/Georges034302/trailer-viewer.git $REPO_DIR
fi

# Run trailer.py to generate the HTML file
echo "Running trailer.py..."
python3 /usr/bin/trailer.py

# Run xsltransformer.py to transform XML and update README.md
echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

# Move the updated README.md and HTML file to the repository directory
echo "Moving updated files..."
mv /tmp/trailer-viewer/trailer.html /tmp/trailer-viewer/trailer.html
mv /tmp/trailer-viewer/README.md /tmp/trailer-viewer/README.md

# Commit and push changes to the repository
echo "Updating repository..."
cd $REPO_DIR
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory $REPO_DIR
git add -A
git commit -m "Update trailer viewer"
git push

echo "==================="
