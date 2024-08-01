#!/bin/bash

echo "==================="

# Clone the repository
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/Georges034302/trailer-viewer.git /tmp/trailer-viewer

# Run the trailer.py script to generate trailer.xml
python3 /usr/bin/trailer.py

# Run the xsltransformer.py script to generate trailer.html and update README.md
python3 /usr/bin/xsltransformer.py

# Move the updated files to the repository
# No need to use mv if the paths are correct in xsltransformer.py
# If needed, use cp to copy files instead
cp /tmp/trailer-viewer/trailer.html /tmp/trailer-viewer/trailer.html
cp /tmp/trailer-viewer/README.md /tmp/trailer-viewer/README.md

# Configure Git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /tmp/trailer-viewer

# Commit and push changes
cd /tmp/trailer-viewer
git add -A
git commit -m "Update trailer HTML and README.md"
git push

echo "==================="
