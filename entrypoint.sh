#!/bin/bash

echo "==================="

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
git push https://x-access-token:${{ secrets.GITHUB_TOKEN }}@github.com/Georges034302/trailer-viewer.git

echo "==================="
