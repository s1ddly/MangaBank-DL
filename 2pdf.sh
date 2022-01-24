#!/bin/bash
# folder to pdf
if [ $# -eq 0 ]; then
	echo "No arguments supplied, please supply the name of the manga to be converted";
	exit 1;
fi

cd ./output/$1;
for f in $(ls); do 
	echo "converting folder: $f";
	convert $f/*g $f/$f.pdf; 
done