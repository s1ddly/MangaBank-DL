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