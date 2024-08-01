#!/bin/bash

echo "==================="

# Setup Git configuration
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

# Ensure the latest files from the repository
echo "Cloning repository to fetch the latest trailer.yaml..."
rm -rf /tmp/trailer-viewer
git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/Georges034302/trailer-viewer.git" /tmp/trailer-viewer

# Debug: Check if files are cloned properly
echo "Debug: Checking /tmp/trailer-viewer contents:"
ls -l /tmp/trailer-viewer/

# Ensure files exist before copying
if [ -f /tmp/trailer-viewer/trailer.yaml ]; then
    echo "Copying trailer.yaml..."
    cp /tmp/trailer-viewer/trailer.yaml /usr/bin/trailer.yaml
else
    echo "Error: trailer.yaml not found in /tmp/trailer-viewer."
    exit 1
fi

if [ -f /tmp/trailer-viewer/README.md ]; then
    echo "Copying README.md..."
    cp /tmp/trailer-viewer/README.md /usr/bin/README.md
else
    echo "Error: README.md not found in /tmp/trailer-viewer."
    exit 1
fi

echo "Running trailer.py..."
python3 /usr/bin/trailer.py

# Debug: Check if trailer.xml is generated
if [ -f /usr/bin/trailer.xml ]; then
    echo "trailer.xml found."
else
    echo "Error: trailer.xml not found."
    exit 1
fi

echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py

# Debug: Check if trailer.html is generated
if [ -f /usr/bin/trailer.html ]; then
    echo "trailer.html found."
else
    echo "Error: trailer.html not found."
    exit 1
fi

# Commit and push changes
echo "Committing and pushing changes..."
cd /tmp/trailer-viewer
cp /usr/bin/trailer.html /tmp/trailer-viewer/
cp /usr/bin/README.md /tmp/trailer-viewer/

git add trailer.html README.md
git commit -m "Update View"
git push origin main

echo "==================="
