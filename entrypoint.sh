#!/bin/bash

echo "==================="

# Clone the repository
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/Georges034302/trailer-viewer.git /tmp/trailer-viewer

# Change directory to the cloned repo
cd /tmp/trailer-viewer

# List files to debug
echo "Files in /tmp/trailer-viewer:"
ls -al

# Run trailer.py to generate trailer.xml
python3 /usr/bin/trailer.py

# Check if trailer.xml was generated
if [ ! -f /tmp/trailer-viewer/trailer.xml ]; then
  echo "Error: trailer.xml not found."
  exit 1
fi

# Run xsltransformer.py to generate trailer.html
python3 /usr/bin/xsltransformer.py

# Check if trailer.html was generated
if [ ! -f /tmp/trailer-viewer/trailer.html ]; then
  echo "Error: trailer.html not found."
  exit 1
fi

# Move the generated files to the GitHub workspace
mv /tmp/trailer-viewer/trailer.html /github/workspace/
mv /tmp/trailer-viewer/README.md /github/workspace/

# Configure Git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Commit and push changes
git add -A
git commit -m "Update trailer HTML and README.md"
git push

echo "==================="
