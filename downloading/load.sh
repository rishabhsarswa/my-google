#!/bin/bash

line="$2"
fno="$1"
echo "$fno $$ $line" > qq/$$

while ! wget -c -q --user="rishu" --password="" "ftp://10.207.109.103:7021//awnto/$line" -O "$line"
do

	echo "--- $$ err retrying .. $line "
	sleep 2

done

 FILE_COUNT=$(find "qq" -maxdepth 1 -type f | wc -l)
echo " $FILE_COUNT $$ $fno $line"

rm qq/$$

