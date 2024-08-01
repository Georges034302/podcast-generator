#!/bin/bash

echo "==================="

# Clone the repository
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/Georges034302/trailer-viewer.git /tmp/trailer-viewer

# Run trailer.py to generate trailer.xml
python3 /usr/bin/trailer.py

# Run xsltransformer.py to generate trailer.html
python3 /usr/bin/xsltransformer.py

# Move the generated files to the repository
mv /tmp/trailer-viewer/trailer.html /tmp/trailer-viewer/README.md /github/workspace/

# Configure Git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Commit and push changes
git add -A
git commit -m "Update trailer HTML and README.md"
git push

echo "==================="
