#!/bin/bash

echo "==================="

# Setup Git configuration
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Ensure the latest files from the repository
echo "Cloning repository to fetch the latest trailer.yaml..."
rm -rf /tmp/trailer-viewer
git clone https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/Georges034302/trailer-viewer.git /tmp/trailer-viewer

# Copy updated files from /tmp to the working directory
echo "Copying updated files..."
cp /tmp/trailer-viewer/trailer.yaml /usr/bin/trailer.yaml
cp /tmp/trailer-viewer/README.md /usr/bin/README.md

# Debug: Check if files are copied correctly
echo "Debug: Checking /usr/bin contents:"
ls -l /usr/bin/

# Run trailer.py to generate trailer.xml
echo "Running trailer.py..."
python3 /usr/bin/trailer.py

# Check if trailer.xml is generated
echo "Debug: Checking /usr/bin for trailer.xml:"
ls -l /usr/bin/trailer.xml

# Run xsltransformer.py to generate HTML
echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

# Check if trailer.html is generated
echo "Debug: Checking /usr/bin for trailer.html:"
ls -l /usr/bin/trailer.html

# Commit and push changes
echo "Committing and pushing changes..."
git add -A
git commit -m "Update View"
git push --set-upstream origin main

echo "==================="
