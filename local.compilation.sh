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
mkdir -p rendered/css
cp -r figures rendered/
mv references.json rendered/

# Create tex file
echo "TeX document"
pandoc thanks_glossary_math.md -s -o rendered/thanks_glossary_math.tex --template=.assets/templates/raw.tex
python .assets/scripts/longtablealign.py #left align table in the glossary
pandoc manuscript.md -s -o rendered/$repo.tex --include-before-body=rendered/thanks_glossary_math.tex --filter pandoc-xnos --bibliography=./rendered/references.json --csl=.assets/templates/ecology-letters.cls --metadata-file=metadata.json --template=.assets/templates/template.tex

# Create html file
echo "HTML document"
cp .assets/templates/style.less rendered/css/
pandoc thanks_glossary_math.md manuscript.md  -o rendered/index.html --filter pandoc-xnos --template=.assets/templates/template.html --bibliography=./rendered/references.json --csl=.assets/templates/ecology-letters.cls --metadata-file=metadata.json --webtex

# Create docx file
echo "MS Word document"
pandoc thanks_glossary_math.md manuscript.md -s -o rendered/$repo.docx --toc --filter pandoc-xnos --bibliography=./rendered/references.json --csl=.assets/templates/ecology-letters.cls --metadata-file=metadata.json

# Create pdf file
python .assets/scripts/cleverefcapitalisefix.py # Fix the issue with cleveref
python .assets/scripts/longtablesmall.py # Fix the issue with longtable package and set font size on small
cd rendered
echo "PDF Document"
latexmk $repo.tex -lualatex --file-line-error --interaction=nonstopmode
latexmk -c # Cleaning up
rm -Rf figures references.json
rm -f references.json
cd ..