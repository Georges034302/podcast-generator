#!/bin/bash

echo "==================="

git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${INPUT_EMAIL}"
git config --global --add safe.directory /github/workspace

python3 /usr/bin/trailer.py

git add -A && git commit -m "Update View"
git push --set-upstream origin main

echo "==================="