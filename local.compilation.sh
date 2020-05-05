#!/bin/bash

repo=ms_M2

# Bibliography part
pandoc-citeproc --bib2json ref_interaction_inference.bib > references.json
python .assets/scripts/bibliography.py

# Adding mandatory files
mkdir -p rendered
cp -r figures rendered/
cp references.json rendered/

# Create tex file
pandoc manuscript.md -s -o rendered/$repo.tex --filter pandoc-xnos --bibliography=references.json --metadata-file=metadata.json --template=.assets/templates/template.tex

# Create pdf file
cd rendered
latexmk $repo.tex -lualatex --file-line-error --interaction=nonstopmode

# Cleaning up
latexmk -c
rm -Rf figures references.json
cd ..
