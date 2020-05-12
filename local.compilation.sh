#!/bin/bash

repo=ms_M2

# Fonts (use if when needed)

#wget --no-check-certificate https://github.com/stipub/stixfonts/archive/master.zip
#unzip master.zip
#mkdir -p rendered/fonts
#mv stixfonts-master/OTF/*.otf rendered/fonts/
#rm -Rf stixfonts-master/ master.zip

# Bibliography part
pandoc-citeproc --bib2json ref_interaction_inference.bib > references.json
python .assets/scripts/bibliography.py

# Adding mandatory files
mkdir -p rendered
cp -r figures rendered/
mv references.json rendered/

# Create tex file
pandoc manuscript.md -s -o rendered/$repo.tex --filter pandoc-xnos --bibliography=./rendered/references.json --metadata-file=metadata.json --template=.assets/templates/template.tex

# Fix the issue with longtable package

python .assets/scripts/longtablefix.py

# Create pdf file
cd rendered
latexmk $repo.tex -lualatex --file-line-error --interaction=nonstopmode

# Cleaning up
latexmk -c
rm -Rf figures references.json
cd ..
