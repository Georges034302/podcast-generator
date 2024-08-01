#!/bin/bash

echo "==================="

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

python3 /usr/bin/trailer.py
python3 /usr/bin/xsltransformer.py

# Run xsltransformer.py with the path to trailer.xsl
echo "Running xsltransformer.py..."
python3 /usr/bin/xsltransformer.py --xslt-path /tmp/Georges034302/trailer-viewer-generator/trailer.xsl --input-xml /Georges034302/trailer-viewer-generator/trailer.xml --output-html /Georges034302/trailer-viewer-generator/trailer.html

git add -A && git commit -m "Update View"
git push --set-upstream origin main

echo "==================="