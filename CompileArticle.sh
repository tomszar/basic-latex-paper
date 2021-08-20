#!/bin/bash

# User input
read -p $'What type of document you want to generate?:\na) PDF\nb) docx\n' letter

outdir="/home/tomas/Dropbox/Manuscripts/Basic Latex Paper/build"
xelatex -interaction=nonstopmode -output-directory="$outdir" sections/appendix.tex 
xelatex -interaction=nonstopmode -output-directory="$outdir" figures.tex 
if [ $letter == 'a' ] 
then
	echo "----------------------------Generating a PDF document----------------------------"
	xelatex -interaction=nonstopmode -output-directory="$outdir" main.tex
	bibtex build/main
	xelatex -interaction=nonstopmode -output-directory="$outdir" main.tex 
	xelatex -interaction=nonstopmode -output-directory="$outdir" main.tex 
elif [ $letter == 'b' ]
then
	echo "----------------------------Generating a DOCX document----------------------------"
	/usr/bin/pandoc main.tex -o build/main.md
	/usr/bin/pandoc build/main.md metadata.yml --mathjax --citeproc --bibliography=references.bib --reference-doc=reference.docx -o build/main.docx
else
	echo "Input was not appropiate"
fi
