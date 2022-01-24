#!/bin/bash
if [ $# -eq 0 ]; then
	echo "No arguments supplied, please supply the series to download, e.g. https://mangabank.xyz/vagabond";
	exit 1;
fi
rm -f ./working/*
name=$(echo $1 | cut -d "/" -f4)
site=$1
mid=$(curl -k -s $site | grep "chapter_list" | cut -d '"' -f7  | sed 's/.$//' | sed 's/^.//')
echo $name $site $mid
echo "Downloading $name from $site";
curl -k -s $site | grep "chapter_list" | cut -d '"' -f16 > ./working/chaplist1.txt;
for f in $(cat ./working/chaplist1.txt | sed 's/,/\n/g'); do 
	echo $f >> ./working/chaplist.txt; 
done
rm -f ./working/chaplist1.txt;
mkdir ./output/$name/;
for f in $(cat ./working/chaplist.txt); do 
	echo "Downloading chapter $f";
	mkdir ./output/$name/$f;
	cid=$(curl -k -s $site/$f | grep "rawChapter" | cut -d "=" -f2   | sed 's/.$//' | sed 's/^.//' |  sed 's/.$//');
	for x in {1..999}; do
		#echo https://cdn.readdetectiveconan.com/file/mangap/$mid/$cid/$x.jpg
		#echo $stat
		stat=$(curl -sw '%{http_code}' -o ./output/$name/$f/$x.jpg https://cdn.readdetectiveconan.com/file/mangap/$mid/$cid/$x.jpg);
		if [ $stat == 404 ]; then 
			rm -f ./output/$name/$f/$x.jpg;
			break;
		fi
	done
done
# touch ./working/chaplist.txt;
# for f in $(cat ./working/chaplist1.txt); do
	# if ! grep -q $f ./working/chaplist.txt; then
		# echo $f >> ./working/chaplist.txt; 
	# fi
# done
# rm -f ./working/chaplist1.txt;
# echo "Identified chapter list";