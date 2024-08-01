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

echo "Running trailer.py..."
python3 /usr/bin/trailer.py

echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

echo "Debug: Checking /tmp/trailer-viewer contents:"
ls -l /tmp/trailer-viewer/

echo "Debug: Checking /usr/bin contents:"
ls -l /usr/bin/

# Commit and push changes
git add -A
git commit -m "Update View"
git push --set-upstream origin main

echo "==================="
