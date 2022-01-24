#!/bin/bash
if [ $# -eq 0 ]; then
	echo "No arguments supplied, please supply the name of the manga to be renamed";
	exit 1;
fi

cd ./output/$1;
for f in $(ls); do 
	echo "renaming folder $f";
	count=1; 
	for z in {001..999}; 
		do if [ -f "$f/$count.jpg" ]; then 
			mv $f/$count.jpg $f/$z.jpg; 
			let "count=count+1"; 
		else 
			break; 
		fi; 
	done; 
done;
