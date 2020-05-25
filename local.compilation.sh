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
echo "TeX document"
pandoc thanks_glossary_math.md -s -o rendered/thanks_glossary_math.tex --template=.assets/templates/raw.tex
python .assets/scripts/longtablealign.py
pandoc manuscript.md -s -o rendered/$repo.tex --include-before-body=rendered/thanks_glossary_math.tex --filter pandoc-xnos --bibliography=./rendered/references.json --metadata-file=metadata.json --template=.assets/templates/template.tex

# Create html file
echo "HTML document"
mkdir -p rendered/css/
cp .assets/templates/style.less rendered/css/
pandoc rendered/$repo.tex -o rendered/index.html --filter pandoc-xnos --template=.assets/templates/template.html --bibliography=./rendered/references.json --metadata-file=metadata.json --webtex

# Create docx file
echo "MS Word document"
pandoc rendered/$repo.tex -s -o rendered/$repo.docx --toc --filter pandoc-xnos --bibliography=./rendered/references.json --metadata-file=metadata.json

# Fix the issue with longtable package

python .assets/scripts/longtablefix.py

# Create pdf file
cd rendered
echo "PDF Document"
latexmk $repo.tex -lualatex --file-line-error --interaction=nonstopmode

# Cleaning up
latexmk -c
rm -Rf figures references.json
cd ..
