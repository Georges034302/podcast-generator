#!/bin/bash

echo "==================="

# Setup Git configuration
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Ensure the latest files from the repository
echo "Cloning repository to fetch the latest trailer.yaml..."
rm -rf /tmp/trailer-viewer
git clone https://x-access-token:${GITHUB_TOKEN}@github.com/Georges034302/trailer-viewer.git /tmp/trailer-viewer

# Copy updated files from /tmp to the working directory
echo "Copying trailer.yaml..."
cp /tmp/trailer-viewer/trailer.yaml /usr/bin/trailer.yaml
echo "Copying README.md..."
cp /tmp/trailer-viewer/README.md /usr/bin/README.md

# Debug: Check the contents of the copied trailer.yaml
echo "Debug: Checking contents of /usr/bin/trailer.yaml"
cat /usr/bin/trailer.yaml

echo "Running trailer.py..."
python3 /usr/bin/trailer.py

echo "Debug: Checking /usr/bin for trailer.xml:"
ls -l /usr/bin/trailer.xml
cat /usr/bin/trailer.xml

echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

echo "Debug: Checking /usr/bin for trailer.html:"
ls -l /usr/bin/trailer.html
cat /usr/bin/trailer.html

# Commit and push changes
git add -A
git commit -m "Update View"
git push --set-upstream origin main

echo "==================="
