#!/usr/bin/env bash

set -e # exit on error

git checkout main
git submodule update --init Pillow
cd Pillow
git fetch --all --tags

if [ $# -eq 0 ]; then
    # Default to the most recently released tag
    tag=$(git tag --list '[0-9]*.[0-9]*.[0-9]*' --sort=-creatordate | head -n 1)
    echo "No release tag given, using the newest one: $tag"
else
    tag=$1
fi

git checkout "$tag"
cd ..
git commit -m "Pillow -> $tag" Pillow
git push
