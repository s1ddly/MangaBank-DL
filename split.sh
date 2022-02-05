#!/bin/bash
# Copy images and pdfs to separate folders
if [ $# -eq 0 ]; then
	echo "No arguments supplied, please supply the name of the manga to be split";
	exit 1;
fi

cd ./output/$1
mkdir ../tmp
mkdir ../tmp/pdfs
mkdir ../tmp/images
mv */*.pdf ../tmp/pdfs
mv * ../tmp/images
mv ../tmp/pdfs ./
mv ../tmp/images ./
rm -r ../tmp
cd ./pdfs; count=1; for f in {001..099}; do mv $count.pdf $f.pdf; let "count=$count+1"; done