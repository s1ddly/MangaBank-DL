#!/bin/bash
if [ $# -eq 0 ]; then
	echo "No arguments supplied, please supply the series to download, e.g. https://mangabank.xyz/vagabond";
	exit 1;
fi
rm -f ./working/*
name=$(echo $1 | cut -d "/" -f4)
site=$1
mid=$(curl -k -s $site | grep "chapter_list" | cut -d '"' -f7  | sed 's/.$//' | sed 's/^.//')
#echo $name $site $mid
echo "Downloading $name from $site";
#curl -k -s $site | grep "chapter_list" | cut -d '"' -f16 > ./working/chaplist1.txt;
IFS='"' read -r -a array <<< $(curl -k -s $site | grep chapter_list)
skip='false'
oustr=''


for element in "${array[@]}"
do
    if [[ $skip == 'false' ]]; then
		if [[ $element == 'chapter_list' ]]; then
			skip='true'
		fi
	elif [[ $skip == 'true' ]]; then
		echo 'Identified chapter list on page'
		skip='done'
	elif [[ $skip == 'done' ]]; then
		echo $element > ./working/chaplist1.txt
		break;
	fi
done

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
		stat=$(curl -sw '%{http_code}' -o ./output/$name/$f/$x.jpg https://cdn.readdetectiveconan.com/file/mangap/$mid/$cid/$x.jpg);
		if [ $stat == 404 ]; then 
			stat=$(curl -sw '%{http_code}' -o ./output/$name/$f/$x.jpg https://cdn.readdetectiveconan.com/file/mangap/$mid/$cid/$x.jpeg);
			if [ $stat == 404 ]; then 
				rm -f ./output/$name/$f/$x.jpg;
				break;
			fi
		fi
	done
done
